import UIKit

protocol BaseViewController {
    func configure()
    func configureNavigationController()
    func configureProperties()
    func configureLayout()
    func configureReactiveBinding()
    var controllerTitle: String { get }
}

extension BaseViewController where Self: UIViewController {
    func configure() {
        configureNavigationController()
        configureProperties()
        configureLayout()
        configureReactiveBinding()
    }

    func configureNavigationController() {
        view.backgroundColor = .white
        navigationItem.title = controllerTitle
        navigationItem.backBarButtonItem?.title = ""
        navigationItem.largeTitleDisplayMode = .always
    }
}


