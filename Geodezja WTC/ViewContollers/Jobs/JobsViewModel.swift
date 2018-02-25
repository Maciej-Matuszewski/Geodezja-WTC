import Foundation
import FirebaseAuth
import FirebaseDatabase
import CodableFirebase
import RxSwift

class JobsViewModel {

    let jobs: Variable<[JobModel]> = Variable([])
    let selectedModel: Variable<JobModel?> = Variable(nil)
    var selectedIndexPath: IndexPath? {
        didSet{
            guard let indexPath = selectedIndexPath else {
                selectedModel.value = nil
                return
            }
            selectedModel.value = jobs.value[indexPath.row]
        }
    }

    init() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let reference = Database.database().reference(withPath: "jobs").child(userID)
        reference.observe(.value) { [weak self] (snapshot) in
            guard let value = snapshot.value else { return }
            self?.jobs.value = (try? FirebaseDecoder().decode([JobModel].self, from: value)) ?? []
        }
    }
}
