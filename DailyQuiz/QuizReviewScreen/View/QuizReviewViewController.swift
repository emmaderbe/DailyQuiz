import UIKit

final class QuizReviewViewController: UIViewController {
    // MARK: - Private dependencies
    private let quizReviewView = QuizReviewView()
    private var viewModel: QuizReviewViewModelProtocol
    private let router: QuizReviewRouterProtocol
    
    // MARK: - Init
    init(viewModel: QuizReviewViewModelProtocol,
         router: QuizReviewRouterProtocol) {
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
        view = quizReviewView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        router.attach(navigationController: self.navigationController)
        setupView()
        setupBindings()
        viewModel.loadQuiz()
    }
}

// MARK: - UI setup
private extension QuizReviewViewController {
    func setupView() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationItem.hidesBackButton = true
        addTarget()
    }
}

// MARK: - Actions
private extension QuizReviewViewController {
    func addTarget() {
        quizReviewView.onRestartTapped = { [weak self] in
            self?.router.goBack()
        }
    }
}

// MARK: - Binding
private extension QuizReviewViewController {
    func setupBindings() {
        viewModel.onDataPrepared = { [weak self] model in
            self?.quizReviewView.configure(
                resultTitle: model.resultTitle,
                resultDescription: model.resultDescription,
                scoreText: model.scoreText,
                stars: model.stars
            )
            self?.quizReviewView.setCards(model.cards)
        }
    }
}
