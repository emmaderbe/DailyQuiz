import UIKit

final class QuizViewController: UIViewController {
    // MARK: - Private properties
    private let quizView = QuizView()
    
    private let questionText = "Как переводится слово «apple»?"
    private let answers = ["Груша", "Яблоко", "Апельсин", "Ананас"]
    private let progress = "Вопрос 1 из 5"
    
    private var selectedIndex: Int?
    
    // MARK: - Lifecycle
    override func loadView() {
        view = quizView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        quizView.setQuestion(question: questionText, progress: progress)
        quizView.setAnswers(answers)
    }
}

// MARK: - Bindings
private extension QuizViewController {
    func setupBindings() {
        quizView.onAnswerSelected = { [weak self] index in
            self?.selectedIndex = index
        }

        quizView.onNextTapped = { [weak self] in
            guard let self = self else { return }
            print("Selected answer index: \(self.selectedIndex ?? -1)")
            quizView.resetAnswerStates()
            
            if answers[selectedIndex ?? 0] == "Яблоко" {
                quizView.updateAnswerState(at: selectedIndex ?? 0, to: .correct)
            } else {
                quizView.updateAnswerState(at: selectedIndex ?? 0, to: .incorrect)
            }
        }
    }
}

