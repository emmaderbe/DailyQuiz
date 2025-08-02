import UIKit

final class ResultsViewController: UIViewController {
    
    private let resultsView = ResultsView()

    override func loadView() {
        view = resultsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureWithMockData()
    }
}

private extension ResultsViewController {
    func configureWithMockData() {
        resultsView.configure(
            resultTitle: "Отличный результат!",
            resultDescription: "Ты ответил(а) правильно на 4 из 5 вопросов. Продолжай в том же духе!",
            scoreText: "4 из 5",
            stars: 4
        )
    }
}
