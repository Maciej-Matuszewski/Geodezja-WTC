import UIKit
import KVNProgress

class OfferDetailsViewController: UIViewController {

    let offerModel: OfferModel

    var offerView: OfferDetailsView! {
        return view as! OfferDetailsView
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    init(offerModel: OfferModel) {
        self.offerModel = offerModel
        super.init(nibName: nil, bundle: nil)
    }

    @available (*,unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = OfferDetailsView(frame: UIApplication.shared.keyWindow?.bounds ?? CGRect.zero)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        offerView.titleLabel.text = offerModel.title
        offerView.titleLabel.textColor = offerModel.image.isDark ? .white : .darkText
        offerView.backgroundImageView.image = offerModel.image
        offerView.descriptionLabel.text = offerModel.description
        offerView.dissmisButton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        offerView.orderButton.addTarget(self, action: #selector(orderAction), for: .touchUpInside)
    }

    @objc func dismissAction() {
        dismiss(animated: true, completion: nil)
    }

    @objc func orderAction() {
        KVNProgress.show()
        dismiss(animated: true) {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            appDelegate.tabBarController.selectedIndex = 1
            KVNProgress.showSuccess()
        }
    }
}
