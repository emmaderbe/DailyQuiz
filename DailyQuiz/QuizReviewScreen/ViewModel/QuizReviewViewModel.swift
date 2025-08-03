import Foundation

// MARK: - QuizReviewViewModelProtocol
protocol QuizReviewViewModelProtocol {
    var onDataPrepared: ((QuizReviewModel) -> Void)? { get set }
    func loadQuiz()
}

// MARK: - QuizReviewViewModel
final class QuizReviewViewModel: QuizReviewViewModelProtocol {
    var onDataPrepared: ((QuizReviewModel) -> Void)?
    
    private let coreDataManager: CoreDataManagerProtocol
    private let formatter: ResultFormatterProtocol
    private let mapper: QuizReviewMapperProtocol
    
    private let quizId: Int
    
    init(coreDataManager: CoreDataManagerProtocol = CoreDataManager(),
         formatter: ResultFormatterProtocol = ResultFormatter(),
         mapper: QuizReviewMapperProtocol = QuizReviewCardMapper(),
         quizId: Int) {
        self.coreDataManager = coreDataManager
        self.formatter = formatter
        self.mapper = mapper
        self.quizId = quizId
    }
}

extension QuizReviewViewModel {
    // Получение данных из Core Data, форматирование и передача
    func loadQuiz() {
        let sessions = coreDataManager.fetchQuizSessions()

        // Поиск нужной сессии по идентификатору
        guard let session = sessions.first(where: { $0.id == quizId }) else {
            return
        }

        // Маппинг вопросов в карточки
        let cards = mapper.map(session: session)
        let resultModel = formatter.formatResult(
            correctAnswers: Int(session.correctAnswers),
            total: cards.count
        )
        
        // Создание модели для экрана
        let data = QuizReviewModel(
            resultTitle: resultModel.resultTitle,
            resultDescription: resultModel.resultDescription,
            scoreText: resultModel.scoreText,
            stars: resultModel.stars,
            cards: cards
        )
        
        onDataPrepared?(data)
    }
}
