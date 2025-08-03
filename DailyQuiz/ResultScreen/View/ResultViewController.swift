import UIKit

final class ResultsViewController: UIViewController {
    // MARK: - Private dependencies
    private let resultsView = ResultsView()
    private var viewModel: ResultsViewModelProtocol
    // MARK: - Private properties
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

// MARK: - UI setup
private extension ResultsViewController {
    func setupView() {
        navigationItem.hidesBackButton = true
        addTarget()
        bindViewModel()
    }
    
    func addTarget() {
        resultsView.onRestartTapped = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }
}

// MARK: - Binding
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
            self?.showErrorAlert()
        }
    }
}

// MARK: - Show error alert
private extension ResultsViewController {
    func showErrorAlert() {
        let alert = CustomAlertView(frame: view.bounds)
        alert.setupMessage(with: "Ошибка",
                           and: "Не удалось загрузить результат. Попробуйте позже.")
        alert.onStartTapped = { [weak alert] in
            alert?.removeFromSuperview()
        }
        resultsView.addSubview(alert)
    }
}
