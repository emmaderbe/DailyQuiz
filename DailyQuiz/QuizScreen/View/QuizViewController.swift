import UIKit

final class QuizViewController: UIViewController {
    // MARK: - Private dependencies
    private let quizView = QuizView()
    private var viewModel: QuizViewModelProtocol
    private let router: QuizRouterProtocol
    
    // MARK: - Private properties
    private var selectedIndex: Int?
    
    // MARK: - Init
    init(viewModel: QuizViewModelProtocol,
         router: QuizRouterProtocol) {
        self.viewModel = viewModel
        self.router = router
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
        router.attach(navigationController: self.navigationController)
        setupView()
    }
}

// MARK: - UI setup
private extension QuizViewController {
    func setupView() {
        navigationItem.hidesBackButton = true
        setupViewModelBindings()
        setupViewBindings()
        showQuestion()
    }
    
    // Отображение текущего вопроса и вариантов ответа
    func showQuestion() {
        let displayModel = viewModel.getDisplayModel()
        
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
            self?.router.goToResultScreen(with: id)
        }
    }
    
    func setupViewBindings() {
        quizView.onAnswerSelected = { [weak self] index in
            self?.selectedIndex = index
        }
        
        quizView.onNextTapped = { [weak self] in
            guard let self, let selected = self.selectedIndex else { return }
            // Отключения взаимодействие с кнопками, подсветка ответа
            let isCorrect = self.viewModel.selectAnswer(at: selected)
            self.quizView.setInteractionEnabled(false)
            self.quizView.resetAnswerStates()
            self.quizView.updateAnswerState(at: selected, to: isCorrect ? .correct : .incorrect)
            
            // Через 2 секунды — переход к следующему вопросу или результатам
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                let shouldShowNext = self.viewModel.goToNext()
                if shouldShowNext {
                    self.showQuestion()
                    self.quizView.setInteractionEnabled(true)
                }
            }
        }
        
        quizView.onBackTapped = { [weak self] in
            self?.router.goBack()
        }
    }
}
