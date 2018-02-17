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
        navigationItem.title = controllerTitle
    }
}


