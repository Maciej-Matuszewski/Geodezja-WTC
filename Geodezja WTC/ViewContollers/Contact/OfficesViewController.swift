import UIKit
import RxSwift
import RxCocoa
import MapKit
import MessageUI

class OfficesViewController: UIViewController {

    fileprivate let disposeBag = DisposeBag()
    fileprivate let viewModel = OfficesViewModel()

    fileprivate let tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.register(OfficesTableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        tableView.rowHeight = 240
        tableView.separatorColor = .clear
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

extension OfficesViewController: BaseViewController {
    var controllerTitle: String {
        return "Offices".localized
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
        Observable.just(viewModel.offices)
            .bind(to: tableView.rx.items(cellIdentifier: "cellIdentifier")) { index, model, cell in
                guard let cell = cell as? OfficesTableViewCell else { return }
                cell.titleLabel.text = model.title
                cell.titleLabel.textColor = model.image.isDark ? .white : .darkText
                cell.backgroundImageView.image = model.image
                cell.addressLabel.text = model.address
                cell.addressLabel.textColor = model.image.isDark ? .white : .darkText

                cell.onMapAction = { [weak self] in
                    self?.openMap(for: model.coordinates)
                }

                cell.onPhoneAction = { [weak self] in
                    self?.call(to: model.phone)
                }

                cell.onMailAction = { [weak self] in
                    self?.mail(to: model.email)
                }
            }
            .disposed(by: disposeBag)
    }

    func openMap(`for` coordinates: CLLocationCoordinate2D) {
        let regionDistance: CLLocationDistance = 10000
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Biuro Geodezji WTC".localized
        mapItem.openInMaps(launchOptions: options)
    }

    func call(to phoneNumber: String) {
        if let url = URL(string: "telprompt:\(phoneNumber)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }

    func mail(to email: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([email])
            present(mail, animated: true, completion: nil)
        }
    }
}

extension OfficesViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
