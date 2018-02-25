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
        loadData()
    }

    func loadData() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let reference = Database.database().reference(withPath: "jobs").child(userID)
        reference.observe(.value) { [weak self] (snapshot) in
            guard let value = snapshot.value,
                let data = try? FirebaseDecoder().decode([String: JobModel].self, from: value)
            else {
                self?.jobs.value = []
                return
            }

            var values = Array(data.values)
            let keys = Array(data.keys)

            for i in 0..<values.count {
                values[i].id = keys[i]
            }

            self?.jobs.value = values.sorted(by: { (modelOne, modelTwo) -> Bool in

                switch (modelOne.needAction, modelTwo.needAction, modelOne.progress, modelTwo.progress) {

                case (true, false, _, _):
                    return true

                case (false, true, _, _):
                    return false

                case (_, _, let progresOne, let progressTwo):
                    return progresOne >= progressTwo
                }
            })
        }
    }
}
