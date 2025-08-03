import Foundation

protocol MainViewModelProtocol {
    var onStateChanged: ((NetworkState) -> Void)? { get set }
    var onSuccess: (([QuestionModel]) -> Void)? { get set }
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
    private let mapper: QuestionMapperProtocol
    
    var onStateChanged: ((NetworkState) -> Void)?
    var onSuccess: (([QuestionModel]) -> Void)?
    var onFailure: (() -> Void)?

    init(networkService: QuizNetworkServiceProtocol = QuizNetworkService(),
         mapper: QuestionMapperProtocol = QuestionMapper()) {
        self.networkService = networkService
        self.mapper = mapper
    }
}

extension MainViewModel {
    func startQuiz(category: String?, difficulty: String?) {
        onStateChanged?(.loading)

        networkService.fetchQuiz(category: category,
                                 difficulty: difficulty) { [weak self] result in
            DispatchQueue.main.async {
                self?.onStateChanged?(.non)
                switch result {
                case .success(let response):
                    let questions = self?.mapper.map(response.results) ?? []
                    self?.onSuccess?(questions)
                case .failure:
                    self?.onFailure?()
                }
            }
        }
    }
}
