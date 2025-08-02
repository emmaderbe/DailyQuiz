import UIKit

final class QuizViewController: UIViewController {
    // MARK: - UI components
    private let quizView = QuizView()
    private var viewModel: QuizViewModelProtocol
    
    // MARK: - Private properties
    private var selectedIndex: Int?
    
    // MARK: - Init
    init(questions: [QuestionModel]) {
        self.viewModel = QuizViewModel(questions: questions)
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        view = quizView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

private extension QuizViewController {
    func setupView() {
        navigationItem.hidesBackButton = true
        setupViewModelBindings()
        setupViewBindings()
        showQuestion()
    }
    
    func showQuestion() {
        guard let displayModel = try? viewModel.getDisplayModel() else { return }
        
        quizView.setText(question: displayModel.questionText,
                         progress: displayModel.progressText,
                         warning: "Вернуться к предыдущим вопросам нельзя")
        quizView.setAnswers(displayModel.answerOptions)
        selectedIndex = nil
    }
}

// MARK: - Bindings
private extension QuizViewController {
    func setupViewModelBindings() {
        viewModel.onQuizFinished = { [weak self] in
            self?.viewModel.saveQuizResult()
            guard let id = self?.viewModel.quizId else { return }
            let resultsVC = ResultsViewController(quizId: id)
            resultsVC.modalPresentationStyle = .fullScreen 
            self?.present(resultsVC, animated: true)
        }
    }
    
    func setupViewBindings() {
        quizView.onAnswerSelected = { [weak self] index in
            self?.selectedIndex = index
        }
        
        quizView.onNextTapped = { [weak self] in
            guard let self, let selected = self.selectedIndex else { return }
            
            let isCorrect = self.viewModel.selectAnswer(at: selected)
            self.quizView.resetAnswerStates()
            self.quizView.updateAnswerState(at: selected, to: isCorrect ? .correct : .incorrect)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                let shouldShowNext = self.viewModel.goToNext()
                if shouldShowNext {
                    self.showQuestion()
                }
            }
        }
        
        quizView.onBackTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}
