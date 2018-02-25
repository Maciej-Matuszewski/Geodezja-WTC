import Foundation
import FirebaseDatabase
import CodableFirebase
import RxSwift

class HomeViewModel {

    let offers: Variable<[OfferModel]> = Variable([])

    init() {
        let reference = Database.database().reference(withPath: "offers")
        reference.observe(.value) { [weak self] (snapshot) in
            guard let value = snapshot.value else { return }
            self?.offers.value = (try? FirebaseDecoder().decode([OfferModel].self, from: value)) ?? []
        }
    }
}
