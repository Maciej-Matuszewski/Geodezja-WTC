import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {

    fileprivate let disposeBag = DisposeBag()
    fileprivate let transition = TransitionIntoOfferDetailsViewController()
    fileprivate let viewModel = HomeViewModel()

    fileprivate let tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        tableView.rowHeight = 240
        tableView.separatorColor = .clear
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

extension HomeViewController: BaseViewController {
    var controllerTitle: String {
        return "Offers".localized
    }

    func configureProperties() {
        transition.dismissCompletion = { [weak self] in
            guard let indexPath = self?.tableView.indexPathForSelectedRow,
                let cell = self?.tableView.cellForRow(at: indexPath) as? HomeTableViewCell
            else { return }
            cell.backgroundImageView.isHidden = false
        }
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
        Observable.just(viewModel.offers)
            .bind(to: tableView.rx.items(cellIdentifier: "cellIdentifier")) { index, model, cell in
                guard let cell = cell as? HomeTableViewCell else { return }
                cell.titleLabel.text = model.title
                cell.titleLabel.textColor = model.image.isDark ? .white : .darkText
                cell.backgroundImageView.image = model.image
            }
            .disposed(by: disposeBag)

        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let offerModel = self?.viewModel.offers[indexPath.row] else { return }
                let detailsViewController = OfferDetailsViewController(offerModel: offerModel)
                detailsViewController.transitioningDelegate = self
                self?.present(detailsViewController, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
}

extension HomeViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        guard let indexPath = tableView.indexPathForSelectedRow,
            let cell = self.tableView.cellForRow(at: indexPath) as? HomeTableViewCell
        else { return transition }

        cell.backgroundImageView.isHidden = true
        transition.originFrame = cell.backgroundImageView.superview!.convert(cell.backgroundImageView.frame, to: nil)
        transition.presenting = true
        return transition
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
}
