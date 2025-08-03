import Foundation

// MARK: - Protocol
protocol ResultsViewModelProtocol {
    var onSuccess: ((ResultsDisplayModel) -> Void)? { get set }
    var onFailure: (() -> Void)? { get set }

    func loadResults(for quizId: Int)
}

final class ResultsViewModel: ResultsViewModelProtocol {
    // MARK: - Public callback
    var onSuccess: ((ResultsDisplayModel) -> Void)?
    var onFailure: (() -> Void)?

    // MARK: - Private dependencies
    private let coreDataManager: CoreDataManagerProtocol
    private let formatter: ResultFormatterProtocol

    // MARK: - Init
    init(coreDataManager: CoreDataManagerProtocol = CoreDataManager(),
         formatter: ResultFormatterProtocol = ResultFormatter()) {
        self.coreDataManager = coreDataManager
        self.formatter = formatter
    }
}

// MARK: - Load data
extension ResultsViewModel {
    func loadResults(for quizId: Int) {
        let sessions = coreDataManager.fetchQuizSessions()
        guard let session = sessions.first(where: { $0.id == Int16(quizId) }) else {
            onFailure?()
            return
        }
        let correct = Int(session.correctAnswers)
        let total = session.questions?.count ?? 5
        let model = formatter.formatResult(correctAnswers: correct, total: total)
        onSuccess?(model)
    }
}
