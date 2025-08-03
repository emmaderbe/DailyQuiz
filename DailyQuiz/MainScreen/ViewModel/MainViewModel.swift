import Foundation

// MARK: - MainViewModelProtocol
protocol MainViewModelProtocol {
    var onStateChanged: ((NetworkState) -> Void)? { get set }
    var onSuccess: (([QuestionModel]) -> Void)? { get set }
    var onFailure: (() -> Void)? { get set }

    func startQuiz(category: String?,
                   difficulty: String?)
}

// MARK: - NetworkState
enum NetworkState {
    case non
    case loading
}

final class MainViewModel: MainViewModelProtocol {
    // MARK: - Private dependecies
    private let networkService: QuizNetworkServiceProtocol
    private let mapper: QuestionMapperProtocol
    
    // MARK: - Public callbacks
    var onStateChanged: ((NetworkState) -> Void)?
    var onSuccess: (([QuestionModel]) -> Void)?
    var onFailure: (() -> Void)?

    // MARK: - Init
    init(networkService: QuizNetworkServiceProtocol = QuizNetworkService(),
         mapper: QuestionMapperProtocol = QuestionMapper()) {
        self.networkService = networkService
        self.mapper = mapper
    }
}

// MARK: - Start quiz
extension MainViewModel {
    // Запрос викторины с выбранной категорией и сложностью (на будущее)
    func startQuiz(category: String?,
                   difficulty: String?) {
        onStateChanged?(.loading)

        networkService.fetchQuiz(category: category,
                                 difficulty: difficulty) { [weak self] result in
            DispatchQueue.main.async {
                self?.onStateChanged?(.non)
                switch result {
                case .success(let response):
                    // Преобразуем данные API в модели для экрана
                    let questions = self?.mapper.map(response.results) ?? []
                    self?.onSuccess?(questions)
                case .failure:
                    self?.onFailure?()
                }
            }
        }
    }
}
