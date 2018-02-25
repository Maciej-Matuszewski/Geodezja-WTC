import UIKit
import KVNProgress
import FirebaseAuth
import SDWebImage

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
        if let imageURL = URL(string: offerModel.imageURL) {
            offerView.backgroundImageView.sd_setImage(with: imageURL, completed: { [weak self] (image, _, _, _) in
                self?.offerView.titleLabel.textColor = image?.isDark ?? false ? .white : .darkText
            })
        }
        offerView.descriptionLabel.text = offerModel.description
        offerView.dissmisButton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        offerView.orderButton.addTarget(self, action: #selector(orderButtonAction), for: .touchUpInside)
    }

    @objc func dismissAction() {
        dismiss(animated: true, completion: nil)
    }

    @objc func orderButtonAction() {
        guard let user = Auth.auth().currentUser else {
            let phoneLoginViewController = PhoneLoginViewController()
            phoneLoginViewController.callback = { [weak self] (user) in
                self?.addOrderTo(user)
            }
            present(phoneLoginViewController, animated: true, completion: nil)
            return
        }
        addOrderTo(user)
    }

    private func addOrderTo(_ user: User) {

        


        KVNProgress.show()
        dismiss(animated: true) {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            appDelegate.tabBarController.selectedIndex = 1
            KVNProgress.showSuccess()
        }
    }
}
