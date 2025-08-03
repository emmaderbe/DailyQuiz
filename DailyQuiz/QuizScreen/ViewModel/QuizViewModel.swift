import Foundation

// MARK: - Protocol
protocol QuizViewModelProtocol {
    var onQuizFinished: (() -> Void)? { get set }
    var quizId: Int { get }
    func getDisplayModel() -> QuizDisplayModel
    func selectAnswer(at index: Int) -> Bool
    func goToNext() -> Bool
    func saveQuizResult()
}

final class QuizViewModel: QuizViewModelProtocol {
    // MARK: - Private property
    private let questions: [QuestionModel]
    private var currentIndex = 0
    private(set) var quizId = 0
    private var selectedAnswers: [Int] = []
    private let date: Date
    private var currentQuestion: QuestionModel {
        questions[currentIndex]
    }
    
    private let coreDataManager: CoreDataManagerProtocol
    
    // MARK: - Public callback
    var onQuizFinished: (() -> Void)?
    
    // MARK: - Init
    init(questions: [QuestionModel],
         coreDataManager: CoreDataManagerProtocol = CoreDataManager(),
         date: Date = Date()) {
        self.questions = questions
        self.coreDataManager = coreDataManager
        self.date = date
    }
}

// MARK: - Protocol methods
extension QuizViewModel {
    func getDisplayModel() -> QuizDisplayModel {
        QuizDisplayModel(
            questionText: currentQuestion.text,
            answerOptions: currentQuestion.answers,
            progressText: "Вопрос \(currentIndex + 1) из \(questions.count)"
        )
    }
    
    func selectAnswer(at index: Int) -> Bool {
        if selectedAnswers.count > currentIndex {
            selectedAnswers[currentIndex] = index
        } else {
            selectedAnswers.append(index)
        }
        
        return index == currentQuestion.correctAnswerIndex
    }
    
    func goToNext() -> Bool {
        currentIndex += 1
        if currentIndex >= questions.count {
            onQuizFinished?()
            return false
        }
        return true
    }
    
    func saveQuizResult() {
        let correctAnswers = zip(questions, selectedAnswers).filter {
            $0.0.correctAnswerIndex == $0.1
        }.count
        
        let id = coreDataManager.nextQuizId()
        self.quizId = id
        
        coreDataManager.saveQuizSession(
            id: coreDataManager.nextQuizId(),
            date: date,
            correctAnswers: correctAnswers,
            questions: questions,
            selectedAnswers: selectedAnswers
        )
    }
}
