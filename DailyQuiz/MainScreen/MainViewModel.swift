import Foundation

protocol MainViewModelProtocol {
    var onStateChanged: ((NetworkState) -> Void)? { get set }
    var onSuccess: (() -> Void)? { get set }
    var onFailure: (() -> Void)? { get set }

    func startQuiz(category: String?,
                   difficulty: String?)
}

enum NetworkState {
    case non
    case loading
}

final class MainViewModel: MainViewModelProtocol {
    private let networkService: QuizNetworkServiceProtocol
    
    var onStateChanged: ((NetworkState) -> Void)?
    var onSuccess: (() -> Void)?
    var onFailure: (() -> Void)?

    init(networkService: QuizNetworkServiceProtocol = QuizNetworkService()) {
        self.networkService = networkService
    }
}

extension MainViewModel {
    func startQuiz(category: String?,
                   difficulty: String?) {
        onStateChanged?(.loading)

        networkService.fetchQuiz(category: category,
                                 difficulty: difficulty) { [weak self] result in
            self?.onStateChanged?(.non)
            switch result {
            case .success:
                self?.onSuccess?()
            case .failure:
                self?.onFailure?()
            }
        }
    }
}
