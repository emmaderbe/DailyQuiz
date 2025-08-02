import Foundation

protocol QuestionMapperProtocol {
    func map(_ response: [QuestionResponse]) -> [QuestionModel]
}

final class QuestionMapper: QuestionMapperProtocol {
    func map(_ response: [QuestionResponse]) -> [QuestionModel] {
        return response.map { item in
            let questionText = item.question.htmlUnescaped
            let correct = item.correctAnswer.htmlUnescaped
            let incorrect = item.incorrectAnswers.map { $0.htmlUnescaped }

            let allAnswers = (incorrect + [correct]).shuffled()
            let correctIndex = allAnswers.firstIndex(of: correct) ?? 0

            return QuestionModel(
                text: questionText,
                answers: allAnswers,
                correctAnswerIndex: correctIndex
            )
        }
    }
}
