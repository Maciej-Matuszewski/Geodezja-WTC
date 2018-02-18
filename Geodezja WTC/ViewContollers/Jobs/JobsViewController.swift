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

    fileprivate lazy var emptyStateView: UIView = {
        return EmptyStateView(
            with: "Ops... There is nothing here :(",
            size: CGSize(
                width: view.frame.width,
                height: tableView.frame.height - (navigationController?.navigationBar.frame.height ?? 0) - (navigationController?.tabBarController?.tabBar.frame.height ?? 0) - 100
            )
        )
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
            .do(onNext: { [weak self] models in
                self?.tableView.tableHeaderView = models.isEmpty ? self?.emptyStateView : nil
            })
            .bind(to: tableView.rx.items(cellIdentifier: "cellIdentifier")) { index, model, cell in
                guard let cell = cell as? JobsTableViewCell else { return }
                cell.progress = model.progress
                cell.titleLabel.text = model.title
                cell.addressLabel.text = model.address
                cell.statusLabel.text = model.status
                cell.actionMark.isHidden = !model.needAction
            }
            .disposed(by: disposeBag)

        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let model = self?.viewModel.jobs[indexPath.row] else { return }
                self?.navigationController?.pushViewController(JobDetailsViewController(model: model), animated: true)
            })
            .disposed(by: disposeBag)
    }
}
