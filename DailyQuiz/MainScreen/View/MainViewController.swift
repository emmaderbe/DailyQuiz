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
    
    func addTarger() {
        mainView.onStartQuizTapped = { [weak self] in
            print("fdefd")
            self?.viewModel.startQuiz(category: nil,
                                      difficulty: nil)
        }
    }
}

private extension MainViewController {
    func setupBindings() {
        viewModel.onStateChanged = { [weak self] state in
            DispatchQueue.main.async {
                switch state {
                case .non:
                    self?.mainView.showLoader(false)
                case .loading:
                    self?.mainView.errorHidden(true)
                    self?.mainView.showLoader(true)
                }
            }
        }

        viewModel.onSuccess = { [weak self] in
            DispatchQueue.main.async {
                print("Успешно")
            }
        }

        viewModel.onFailure = { [weak self] in
            DispatchQueue.main.async {
                self?.mainView.errorHidden(false)
            }
        }
    }
}
