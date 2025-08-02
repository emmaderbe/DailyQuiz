import UIKit

final class HistoryViewController: UIViewController {

    // MARK: - Private properties
    private let historyView = HistoryView()
    private let dataSource = HistoryDataSource()

    private let mockEmptyResults: [QuizResultModel] = []
    
    private let mockFilledResults: [QuizResultModel] = [
        QuizResultModel(title: "Quiz 1", date: makeDate(day: 7, hour: 12, minute: 3), stars: 3),
        QuizResultModel(title: "Quiz 2", date: makeDate(day: 8, hour: 14, minute: 15), stars: 2),
        QuizResultModel(title: "Quiz 3", date: makeDate(day: 9, hour: 9, minute: 30), stars: 3),
        QuizResultModel(title: "Quiz 4", date: makeDate(day: 10, hour: 16, minute: 45), stars: 4),
        QuizResultModel(title: "Quiz 5", date: makeDate(day: 11, hour: 11, minute: 0), stars: 2)
    ]
    
    // MARK: - Lifecycle
    override func loadView() {
        view = historyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

private extension HistoryViewController {
    func setupView() {
        setupAction()
        historyView.setDataSource(dataSource)
        historyView.setupText(with: "История",
                              and: "Вы еще не проходили ни одной викторины")
        
        let results = mockEmptyResults
        
        dataSource.updateResults(results)
        historyView.reloadData()
        historyView.setEmptyViewHidden(!results.isEmpty)
    }
    
    func setupAction() {
        historyView.onStartTapped = { [weak self] in
            print("Начать викторину")
        }
    }
    
    static func makeDate(day: Int, hour: Int, minute: Int) -> Date {
        var components = DateComponents()
        components.year = 2025
        components.month = 7
        components.day = day
        components.hour = hour
        components.minute = minute
        return Calendar.current.date(from: components) ?? Date()
    }
}

