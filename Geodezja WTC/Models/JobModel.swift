import Foundation
import UIKit

struct JobModel {
    let title: String
    let address: String
    let status: String
    let progress: CGFloat
    let needAction: Bool
    let stages: [JobStageModel]
}

struct JobStageModel {
    let title: String
    let action: JobStageAction
    let state: JobStageState
    let documentURL: String?
}

enum JobStageAction {
    case none
    case document
    case accept
}

enum JobStageState {
    case waiting
    case inProgress
    case completed
}
