import Foundation

final class HistoryScreenAssembly {
    func makeHistoryScreen() -> HistoryViewController {
        let coreData = CoreDataManager()
        let router = HistoryRouter()
        let viewModel = HistoryViewModel(coreDataManager: coreData)
        return HistoryViewController(viewModel: viewModel,
                                     router: router)
    }
}
