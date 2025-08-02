import UIKit

final class ResultsViewController: UIViewController {
    // MARK: - Private properties
    private let resultsView = ResultsView()
    private var viewModel: ResultsViewModelProtocol
    private let quizId: Int
    
    // MARK: - Init
    init(viewModel: ResultsViewModelProtocol = ResultsViewModel(),
         quizId: Int) {
        self.viewModel = viewModel
        self.quizId = quizId
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        view = resultsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.viewModel.loadResults(for: quizId)
    }
}

private extension ResultsViewController {
    func setupView() {
        bindViewModel()
    }
}

private extension ResultsViewController {
    func bindViewModel() {
        viewModel.onSuccess = { [weak self] model in
            self?.resultsView.configure(
                resultTitle: model.resultTitle,
                resultDescription: model.resultDescription,
                scoreText: model.scoreText,
                stars: model.stars
            )
        }

        viewModel.onFailure = { [weak self] in
            print("Произошла ошибка")
        }
    }
}

