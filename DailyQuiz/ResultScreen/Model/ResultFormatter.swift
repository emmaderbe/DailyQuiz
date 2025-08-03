import Foundation

// MARK: - ResultFormatterProtocol
protocol ResultFormatterProtocol {
    func formatResult(correctAnswers: Int, total: Int) -> ResultsDisplayModel
}

// MARK: - ResultFormatter
final class ResultFormatter: ResultFormatterProtocol {
    func formatResult(correctAnswers: Int,
                      total: Int) -> ResultsDisplayModel {
        let title: String
        let subtitle: String

        switch correctAnswers {
        case 5:
            title = "Идеально!"
            subtitle = "5/5 — вы ответили на всё правильно. Это блестящий результат!"
        case 4:
            title = "Почти идеально!"
            subtitle = "4/5 — очень близко к совершенству. Ещё один шаг!"
        case 3:
            title = "Хороший результат!"
            subtitle = "3/5 — вы на верном пути. Продолжайте тренироваться!"
        case 2:
            title = "Есть над чем поработать"
            subtitle = "2/5 — не расстраивайтесь, попробуйте ещё раз!"
        case 1:
            title = "Сложный вопрос?"
            subtitle = "1/5 — иногда просто не ваш день. Следующая попытка будет лучше!"
        default:
            title = "Бывает и так!"
            subtitle = "0/5 — не отчаивайтесь. Начните заново и удивите себя!"
        }

        return ResultsDisplayModel(
            resultTitle: title,
            resultDescription: subtitle,
            scoreText: "\(correctAnswers) из \(total)",
            stars: correctAnswers
        )
    }
}
