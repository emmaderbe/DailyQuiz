import UIKit

class MainViewController: UIViewController {
    // MARK: - Private properties
    private let mainView = MainView()
    private var viewModel: MainViewModelProtocol
    
    // MARK: - Init
    init(viewModel: MainViewModelProtocol = MainViewModel()) {
        self.viewModel = viewModel
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
        setupView()
        setupBindings()
    }
}

// MARK: - UI Setup
private extension MainViewController {
    func setupView() {
        setupText()
        mainView.showLoader(false)
        addTarger()
    }
    
    func setupText() {
        mainView.configureView(with: "Добро пожаловать в DailyQuiz!",
                               and: "Ошибка! Попробуйте ещё раз")
    }
}

private extension MainViewController {
    func addTarger() {
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
            let historyVC = HistoryViewController()
            self?.navigationController?.pushViewController(historyVC, animated: true)
        }
    }
}

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
        
        viewModel.onSuccess = { [weak self] questions in
                let quizVC = QuizViewController(questions: questions)
                self?.navigationController?.pushViewController(quizVC, animated: true)
        }
        
        viewModel.onFailure = { [weak self] in
                self?.mainView.errorHidden(false)
        }
    }
}
