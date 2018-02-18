import UIKit

class WTCNavigationController: UINavigationController {

    init(rootViewController: UIViewController, tabBarIcon: UIImage, tabBarTitle: String) {
        super.init(nibName: nil, bundle: nil)
        viewControllers = [rootViewController]
        tabBarItem.title = tabBarTitle
        tabBarItem.image = tabBarIcon
        navigationBar.tintColor = .main
        navigationBar.barTintColor = .white
        navigationBar.prefersLargeTitles = true
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
        view.backgroundColor = .white

    }

    @available (*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
