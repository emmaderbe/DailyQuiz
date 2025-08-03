import Foundation

protocol HistoryViewModelProtocol {
    var onDataLoaded: (([QuizResultModel]) -> Void)? { get set }
    
    func loadHistory()
}

final class HistoryViewModel: HistoryViewModelProtocol {
    private let coreDataManager: CoreDataManagerProtocol
    var onDataLoaded: (([QuizResultModel]) -> Void)?

    init(coreDataManager: CoreDataManagerProtocol = CoreDataManager()) {
        self.coreDataManager = coreDataManager
    }
}

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
