import Foundation
import UIKit

struct JobModel: Codable {
    var id: String?
    let title: String
    let address: String
    let stages: [JobStageModel]

    var status: String {
        guard let currentStage = (
            stages.first { $0.state == .inProgress }
            ?? stages.filter { $0.state == .completed }.last
            ?? stages.first
        ) else { return "" }
        return currentStage.title.uppercased()
    }

    var progress: CGFloat {
        var sum = 0
        stages.forEach { model in
            sum += model.state.hashValue
        }
        return CGFloat(sum) / CGFloat(stages.count * 2)
    }

    var needAction: Bool {
        return stages.first(where: { $0.state == .inProgress && ($0.action == .accept || $0.action == .file) }) != nil
    }
}

struct JobStageModel: Codable {
    let title: String
    let action: JobStageAction
    let state: JobStageState
    let documentURL: String?
}

enum JobStageAction: Int, Codable {
    case none = 0
    case document = 1
    case accept = 2
    case file = 3
}

enum JobStageState: Int, Codable {
    case waiting = 0
    case inProgress = 1
    case completed = 2
}
