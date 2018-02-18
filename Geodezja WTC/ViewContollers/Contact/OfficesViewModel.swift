import Foundation
import MapKit

class OfficesViewModel {
    let offices: [OfficeModel] = [
        OfficeModel(
            title: "Grudziądz",
            image: #imageLiteral(resourceName: "grudziadz"),
            address: "Aleja 23 Stycznia 18, 86-300 Grudziądz",
            phone: "+48 566426657",
            email: "biuro_geodezjigr@tlen.pl",
            coordinates: CLLocationCoordinate2D(latitude: 53.4897797, longitude: 18.7460448)
        ),
        OfficeModel(
            title: "Lipno",
            image: #imageLiteral(resourceName: "offer_005"),
            address: "ul. Mickiewicza 10/12, 87-600 Lipno",
            phone: "+48 542883275",
            email: "biuro_geodezji@tlen.pl",
            coordinates: CLLocationCoordinate2D(latitude: 52.8455636, longitude: 19.1768391)
        )
    ]
}
