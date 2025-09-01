import Foundation

final class ResultAssembly {
    func makeScreen(with id: Int) -> ResultsViewController {
        let coreData = CoreDataManager()
        let formatter = ResultFormatter()
        let router = ResultRouter()
        let viewModel = ResultsViewModel(coreDataManager: coreData,
                                         formatter: formatter)
        return ResultsViewController(viewModel: viewModel,
                                     quizId: id, router: router)
    }
}
