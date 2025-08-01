import UIKit

final class ResultsViewController: UIViewController {
    
    private let resultsView = ResultsView()

    override func loadView() {
        view = resultsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        configureWithMockData()
    }
}

private extension ResultsViewController {
    func setupBindings() {
        resultsView.onRestartTapped = { [weak self] in
            print("Кнопка 'Начать заново' нажата")
        }
    }

    func configureWithMockData() {
        resultsView.configure(
            resultTitle: "Отличный результат!",
            resultDescription: "Ты ответил(а) правильно на 4 из 5 вопросов. Продолжай в том же духе!",
            scoreText: "4 из 5",
            stars: 4
        )
    }
}
