import UIKit

final class QuizReviewViewController: UIViewController {
    // MARK: - Private properties
    private let quizReviewView = QuizReviewView()
    private var viewModel: QuizReviewViewModelProtocol
    
    init(id: Int) {
        self.viewModel = QuizReviewViewModel(quizId: id)
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
        setupView()
        setupBindings()
        viewModel.loadQuiz()
    }
}

private extension QuizReviewViewController {
    func setupView() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationItem.hidesBackButton = true
        addTarget()
    }
    
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

    func addTarget() {
        quizReviewView.onRestartTapped = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }
}
