import UIKit
import RxSwift
import RxCocoa

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
        view.backgroundColor = .background
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

        Observable.just(viewModel.jobs)
            .bind(to: tableView.rx.items(cellIdentifier: "cellIdentifier")) { index, model, cell in
                guard let cell = cell as? JobsTableViewCell else { return }
                cell.progress = model.progress
                cell.titleLabel.text = model.title
                cell.addressLabel.text = model.address
                cell.statusLabel.text = model.status
                cell.actionMark.isHidden = !model.needAction
            }
            .disposed(by: disposeBag)

//        tableView.rx.itemSelected
//            .subscribe(onNext: { [weak self] indexPath in
//                
//            })
//            .disposed(by: disposeBag)
    }
}
