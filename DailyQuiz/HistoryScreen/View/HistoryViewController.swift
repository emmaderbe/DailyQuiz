import UIKit

final class HistoryViewController: UIViewController {

    // MARK: - Private dependencies
    private let historyView = HistoryView()
    private let dataSource = HistoryDataSource()
    private let delegate = HistoryDelegate()
    private var viewModel: HistoryViewModelProtocol

    // MARK: - Init
    init(viewModel: HistoryViewModelProtocol = HistoryViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        view = historyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
        viewModel.loadHistory()
    }
}

// MARK: - UI setup
private extension HistoryViewController {
    func setupView() {
        navigationItem.hidesBackButton = true
        setupAction()
        setupCollection()
        historyView.setupText(with: "История",
                              and: "Вы еще не проходили ни одной викторины")
    }
    
    func setupCollection() {
        historyView.setDataSource(dataSource)
        historyView.setupDelegate(delegate)
        delegate.delegate = self
    }
}

// MARK: - Actions
private extension HistoryViewController {
    func setupAction() {
        startTapped()
        backTapped()
    }
    
    func startTapped() {
        historyView.onStartTapped = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func backTapped() {
        historyView.onBackTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - Binding
private extension HistoryViewController {
    func setupBindings() {
        viewModel.onDataLoaded = { [weak self] results in
            self?.dataSource.updateResults(results)
            self?.delegate.updateItems(results)
            self?.historyView.reloadData()
            self?.historyView.setEmptyViewHidden(results.isEmpty)
        }
    }
}

// MARK: - HistoryDelegateProtocol
extension HistoryViewController: HistoryDelegateProtocol {
    // Удаление элемента истории по id
    func quizDeleted(_ id: Int) {
        viewModel.deleteHistoryItem(id: id)
        showDeletedAlert()
    }
    
    // Переход к экрану разбора викторины по id
    func quizSelected(_ id: Int) {
        let vc = QuizReviewViewController(id: id)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Show deleted alert
private extension HistoryViewController {
    // Отображение алерта после удаления попытки
    func showDeletedAlert() {
        let alert = CustomAlertView(frame: view.bounds)
        alert.setupMessage(with: "Попытка удалена",
                           and: "Вы можете пройти викторину снова, когда будете готовы.")

        alert.onStartTapped = { [weak alert] in
            alert?.removeFromSuperview()
        }
        historyView.addSubview(alert)
    }
}
