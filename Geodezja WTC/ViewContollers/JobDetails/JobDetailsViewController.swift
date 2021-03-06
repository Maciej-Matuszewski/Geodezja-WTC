import UIKit
import RxSwift
import RxCocoa
import SafariServices
import KVNProgress
import FirebaseDatabase
import FirebaseAuth

class JobDetailsViewController: UIViewController {

    fileprivate let disposeBag = DisposeBag()
    fileprivate let model: Variable<JobModel?>

    fileprivate let tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.register(JobDetailsTableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        tableView.rowHeight = 110
        tableView.separatorColor = .clear
        return tableView
    }()

    init(model: Variable<JobModel?>) {
        self.model = model//Variable(model)
        super.init(nibName: nil, bundle: nil)
    }

    @available (*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

extension JobDetailsViewController: BaseViewController {
    var controllerTitle: String {
        return model.value?.title ?? ""
    }

    func configureProperties() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.backBarButtonItem?.title = ""
    }

    func configureLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func configureReactiveBinding() {

        model.asObservable()
            .map { $0?.stages ?? [] }
            .bind(to: tableView.rx.items(cellIdentifier: "cellIdentifier")) { [weak self] index, model, cell in
                guard let cell = cell as? JobDetailsTableViewCell else { return }
                cell.titleLabel.text = model.title
                cell.progress = model.state == .completed ? 1.0 : 0.0
                cell.frontView.alpha = model.state == .waiting ? 0.4 :  1.0
                cell.topLineView.isHidden = index == 0
                cell.bottomLineView.isHidden = index == (self?.model.value?.stages.count ?? 0) - 1

                switch(model.action, model.state) {
                case (.none, _), (_, .waiting), (.document, .inProgress):
                    cell.actionMark.text = ""
                    cell.actionMark.isHidden = true
                    break
                case (.document, _):
                    cell.actionMark.text = "✉︎"
                    cell.actionMark.isHidden = false
                    break
                case (.accept, .completed), (.file, .completed):
                    cell.actionMark.text = "✔︎"
                    cell.actionMark.isHidden = false
                    break
                case (.accept, .inProgress):
                    cell.actionMark.text = "✍︎"
                    cell.actionMark.isHidden = false
                    break
                case (.file, .inProgress):
                    cell.actionMark.text = "＋"
                    cell.actionMark.isHidden = false
                    break
                }
            }
            .disposed(by: disposeBag)

        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let model = self?.model.value?.stages[indexPath.row] else { return }
                switch(model.action, model.state) {
                case (.document, .completed):
                    guard let urlString = model.documentURL else { return }
                    self?.presentDocument(with: urlString)
                    return
                case (.accept, .inProgress):
                    self?.accept(stage: model, withNumber: indexPath.row)
                    return
                case (.file, .inProgress):
                    self?.uploadFile()
                    return
                default:
                    return
                }
            })
            .disposed(by: disposeBag)
    }

    private func presentDocument(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.preferredBarTintColor = .white
        safariViewController.preferredControlTintColor = .main
        present(safariViewController, animated: true, completion: nil)
    }

    private func accept(stage: JobStageModel, withNumber number: Int) {
        let alertController = UIAlertController(title: stage.title, message: "Would you like to accept this stage?".localized, preferredStyle: .alert)
        alertController.addAction(
            UIAlertAction(title: "Yes".localized, style: .default, handler: { [weak self] _ in
                KVNProgress.show()

                guard let userID = Auth.auth().currentUser?.uid,
                    let jobID = self?.model.value?.id
                else {
                    KVNProgress.showError()
                    return
                }
                Database.database().reference(withPath: "jobs/\(userID)/\(jobID)/stages/\(number)/state").setValue(2, withCompletionBlock: { (error, reference) in
                    if error != nil {
                        KVNProgress.showError()
                        return
                    }
                    KVNProgress.showSuccess()
                })
            })
        )
        alertController.addAction(
            UIAlertAction(title: "Contact me".localized, style: .default, handler: { [weak self] _ in
                KVNProgress.show()
                let currentDate: String = {
                    let date = Date()
                    let calender = Calendar.current
                    let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)

                    let year = components.year
                    let month = components.month
                    let day = components.day
                    let hour = components.hour
                    let minute = components.minute
                    let second = components.second

                    let today_string = String(year!) + "-" + String(month!) + "-" + String(day!) + " " + String(hour!)  + ":" + String(minute!) + ":" +  String(second!)

                    return today_string
                }()

                let reference = Database.database()
                let request: [String: Any?] = [
                    "jobID": self?.model.value?.id ?? "-",
                    "userID": Auth.auth().currentUser?.uid ?? "-",
                    "userPhone": Auth.auth().currentUser?.phoneNumber ?? "-",
                    "resolved": false,
                    "date": currentDate
                ]

                reference.reference(withPath: "contactRequests").childByAutoId().setValue(request, withCompletionBlock: { (error, reference) in
                    if error != nil {
                        KVNProgress.showError()
                        return
                    }
                    KVNProgress.showSuccess()
                })

            })
        )
        alertController.addAction(
            UIAlertAction(title: "Not yet".localized, style: .cancel, handler: nil)
        )
        alertController.view.tintColor = .main
        present(alertController, animated: true, completion: nil)
    }

    func uploadFile() {
    }
}
