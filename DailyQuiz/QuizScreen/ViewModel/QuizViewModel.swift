import Foundation

// MARK: - Protocol
protocol QuizViewModelProtocol {
    var onQuizFinished: (() -> Void)? { get set }

    func getDisplayModel() -> QuizDisplayModel
    func selectAnswer(at index: Int) -> Bool
    func goToNext() -> Bool
}


final class QuizViewModel: QuizViewModelProtocol {
    // MARK: - Private property
    private let questions: [QuestionModel]
    private var currentIndex = 0
    private var currentQuestion: QuestionModel {
        questions[currentIndex]
    }

    // MARK: - Public callback
    var onQuizFinished: (() -> Void)?

    // MARK: - Init
    init(questions: [QuestionModel]) {
        self.questions = questions
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
}
