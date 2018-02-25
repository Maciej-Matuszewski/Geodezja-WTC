import UIKit
import RxSwift
import RxCocoa
import FirebaseAuth

class JobsViewController: UIViewController {

    fileprivate let disposeBag = DisposeBag()
    fileprivate let viewModel = JobsViewModel()
    fileprivate let tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.register(JobsTableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        tableView.rowHeight = 110
        tableView.separatorColor = .clear
        return tableView
    }()

    fileprivate var emptyStateView: UIView {
        let viewSize = CGSize(
            width: view.frame.width,
            height: tableView.frame.height - (navigationController?.navigationBar.frame.height ?? 0) - (navigationController?.tabBarController?.tabBar.frame.height ?? 0) - 100
        )
        return Auth.auth().currentUser != nil ? EmptyStateView(
            with: "Ops... There is nothing here :(".localized,
            size: viewSize
        ) : LoginStateView(
            with: "Please login to display yours current jobs!".localized,
            size: viewSize,
            onButtonClick: { [weak self] in
                let phoneLoginViewController = PhoneLoginViewController()
                phoneLoginViewController.callback = { [weak self] _ in
                    self?.viewModel.loadData()
                }
                self?.present(phoneLoginViewController, animated: true, completion: nil)
            }
        )
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

extension JobsViewController: BaseViewController {
    var controllerTitle: String {
        return "Current jobs".localized
    }

    func configureProperties() {}

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
        viewModel.jobs.asObservable()
            .do(onNext: { [weak self] models in
                self?.tableView.tableHeaderView = models.isEmpty ? self?.emptyStateView : nil
            })
            .bind(to: tableView.rx.items(cellIdentifier: "cellIdentifier")) { index, model, cell in
                guard let cell = cell as? JobsTableViewCell else { return }
                cell.progress = model.progress
                cell.titleLabel.text = model.title
                cell.addressLabel.text = model.id
                cell.statusLabel.text = model.status
                cell.actionMark.isHidden = !model.needAction
            }
            .disposed(by: disposeBag)

        viewModel.jobs.asObservable()
            .map {[weak self] models -> JobModel? in
                let indexPathRow = self?.viewModel.selectedIndexPath?.row ?? 0
                if models.count > indexPathRow {
                    return models[indexPathRow]
                }
                return nil
            }
            .bind(to: viewModel.selectedModel)
            .disposed(by: disposeBag)

        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.viewModel.selectedIndexPath = indexPath
                self?.navigationController?.pushViewController(JobDetailsViewController(model: self?.viewModel.selectedModel ?? Variable(nil)), animated: true)
            })
            .disposed(by: disposeBag)
    }
}
