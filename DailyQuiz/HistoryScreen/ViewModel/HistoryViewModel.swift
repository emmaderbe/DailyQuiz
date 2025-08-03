import Foundation

// MARK: - HistoryViewModelProtocol
protocol HistoryViewModelProtocol {
    var onDataLoaded: (([QuizResultModel]) -> Void)? { get set }
    func loadHistory()
}

final class HistoryViewModel: HistoryViewModelProtocol {
    // MARK: - Private dependency
    private let coreDataManager: CoreDataManagerProtocol
    
    // MARK: - Public callback
    var onDataLoaded: (([QuizResultModel]) -> Void)?

    // MARK: - Init
    init(coreDataManager: CoreDataManagerProtocol = CoreDataManager()) {
        self.coreDataManager = coreDataManager
    }
}

// MARK: - Load data
extension HistoryViewModel {
    func loadHistory() {
        let sessions = coreDataManager.fetchQuizSessions()
        
        let models = sessions.map {
            QuizResultModel(
                id: Int($0.id),
                title: "Quiz \($0.id)",
                date: $0.date ?? Date(),
                stars: Int($0.correctAnswers)
            )
        }.sorted(by: { $0.date < $1.date })
        
        onDataLoaded?(models)
    }
}
