import Foundation

// MARK: - HistoryViewModelProtocol
protocol HistoryViewModelProtocol {
    var onDataLoaded: (([QuizResultModel]) -> Void)? { get set }
    func loadHistory()
    func deleteHistoryItem(id: Int)
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
    // Получение и сортировка истории из Core Data
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

// MARK: - Delete item
extension HistoryViewModel {
    // Удаление сессии викторины по идентификатору и обновление истории
    func deleteHistoryItem(id: Int) {
        coreDataManager.deleteSessionById(id)
        loadHistory()
    }
}
