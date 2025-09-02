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
            title = String(localized: "quizResultTitleCase5")
            subtitle = String(localized: "quizResultDescriptionCase5")
        case 4:
            title = String(localized: "quizResultTitleCase4")
            subtitle = String(localized: "quizResultDescriptionCase4")
        case 3:
            title = String(localized: "quizResultTitleCase3")
            subtitle = String(localized: "quizResultDescriptionCase3")
        case 2:
            title = String(localized: "quizResultTitleCase2")
            subtitle = String(localized: "quizResultDescriptionCase2")
        case 1:
            title = String(localized: "quizResultTitleCase1")
            subtitle = String(localized: "quizResultDescriptionCase1")
        default:
            title = String(localized: "quizResultTitleDefault")
            subtitle = String(localized: "quizResultDescriptionDefault")
        }

        return ResultsDisplayModel(
            resultTitle: title,
            resultDescription: subtitle,
            scoreText: "\(correctAnswers) из \(total)",
            stars: correctAnswers
        )
    }
}
