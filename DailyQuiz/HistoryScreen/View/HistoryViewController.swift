import UIKit

final class HistoryViewController: UIViewController {

    // MARK: - Private properties
    private let historyView = HistoryView()
    private let dataSource = HistoryDataSource()
    
    private var viewModel: HistoryViewModelProtocol

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
        viewModel.loadHistory()
    }
}

// MARK: - UI setup
private extension HistoryViewController {
    func setupView() {
        setupAction()
        setupDataSource()
        setupBindings()
        historyView.setupText(with: "История",
                              and: "Вы еще не проходили ни одной викторины")
    }
    
    func setupDataSource() {
        historyView.setDataSource(dataSource)
    }
    
    func setupAction() {
        historyView.onStartTapped = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }
}

private extension HistoryViewController {
    func setupBindings() {
        viewModel.onDataLoaded = { [weak self] results in
            self?.dataSource.updateResults(results)
            self?.historyView.reloadData()
            self?.historyView.setEmptyViewHidden(!results.isEmpty)
        }
    }
}

