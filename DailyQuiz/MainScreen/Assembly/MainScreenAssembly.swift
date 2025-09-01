import Foundation

final class MainScreenAssembly {
    func makeScreen() -> MainViewController {
        let network = QuizNetworkService()
        let mapper = QuestionMapper()
        let router = MainRouter()
        let viewModel = MainViewModel(networkService: network,
                                      mapper: mapper)
        return MainViewController(viewModel: viewModel,
                                  router: router)
    }
}
