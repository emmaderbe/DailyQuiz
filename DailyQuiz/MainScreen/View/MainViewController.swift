import UIKit

class MainViewController: UIViewController {
    // MARK: - Private dependencies
    private let mainView = MainView()
    private let router: MainRouterProtocol
    private var viewModel: MainViewModelProtocol
    
    // MARK: - Init
    init(viewModel: MainViewModelProtocol,
         router: MainRouterProtocol) {
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
        self.view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        router.attach(navigationController: self.navigationController)
        setupView()
        setupBindings()
    }
}

// MARK: - UI Setup
private extension MainViewController {
    func setupView() {
        setupText()
        mainView.showLoader(false)
        addTarget()
    }
    
    func setupText() {
        mainView.configureView(with: String(localized: "welcomeTitle"),
                               and: String(localized: "warningMainLabel"))
    }
}

// MARK: - Actions
private extension MainViewController {
    func addTarget() {
        startTapped()
        historyTapped()
    }
    
    func startTapped() {
        mainView.onStartQuizTapped = { [weak self] in
            self?.viewModel.startQuiz(category: nil,
                                      difficulty: nil)
        }
    }
    
    func historyTapped() {
        mainView.onHistoryTapped = { [weak self] in
            self?.router.goToHistoryScreen()
        }
    }
}

// MARK: - Binding
private extension MainViewController {
    func setupBindings() {
        viewModel.onStateChanged = { [weak self] state in
            switch state {
            case .non:
                self?.mainView.showLoader(false)
            case .loading:
                self?.mainView.errorHidden(true)
                self?.mainView.showLoader(true)
            }
        }
        
        // Обработка успешного получения данных
        viewModel.onSuccess = { [weak self] questions in
            self?.router.goToQuizScreen(with: questions)
        }
        
        // Обработка ошибки загрузки данных
        viewModel.onFailure = { [weak self] in
            self?.mainView.errorHidden(false)
        }
    }
}
