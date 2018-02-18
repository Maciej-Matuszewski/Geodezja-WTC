import Foundation

class JobsViewModel {
    let jobs: [JobModel] = [
        JobModel(
            title: "Mapy do celów projektowych",
            address: "ul. Waleniowa 3, 85-435 Bydgoszcz",
            status: "PRACE W TERENIE",
            progress: 0.4,
            needAction: true,
            stages: [
                JobStageModel(
                    title: "Przygotowanie wyceny",
                    action: .document,
                    state: .completed,
                    documentURL: "http://www.africau.edu/images/default/sample.pdf"
                ),
                JobStageModel(
                    title: "Akceptacja wyceny",
                    action: .accept,
                    state: .completed,
                    documentURL: nil
                ),
                JobStageModel(
                    title: "Przygotowanie dokumentów",
                    action: .document,
                    state: .completed,
                    documentURL: "http://www.africau.edu/images/default/sample.pdf"
                ),
                JobStageModel(
                    title: "Akceptacja dokumentów",
                    action: .accept,
                    state: .inProgress,
                    documentURL: nil
                ),
                JobStageModel(
                    title: "Prace w terenie",
                    action: .none,
                    state: .waiting,
                    documentURL: nil
                ),
                JobStageModel(
                    title: "Przygotowanie map",
                    action: .document,
                    state: .waiting,
                    documentURL: nil
                ),
                JobStageModel(
                    title: "Odbiór prac",
                    action: .accept,
                    state: .waiting,
                    documentURL: nil
                ),
            ]
        ),
        JobModel(title: "Tyczenie obiektów budowlanych", address: "ul. Milczańska 14, 61-131 Poznań", status: "OCZEKIWANIE NA KONTAKT", progress: 0.0, needAction: false, stages: []),
        JobModel(title: "Ustalenia przebiegów granic", address: "al. 23-go Stycznia 18, 86-300 Grudziądz", status: "OCZEKIWANIE NA ODBIÓR", progress: 1.0, needAction: false, stages: []),
        JobModel(title: "Podziały nieruchomości", address: "ul. Piotrowo 1, 61-137 Poznań", status: "PRZYGOTOWYWANIE WYCENY", progress: 0.2, needAction: false, stages: []),
    ]
}
