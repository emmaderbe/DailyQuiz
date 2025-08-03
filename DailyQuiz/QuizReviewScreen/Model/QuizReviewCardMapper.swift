import Foundation

// MARK: - QuizReviewMapperProtocol
protocol QuizReviewMapperProtocol {
    func map(session: QuizSessionEntity) -> [QuizReviewCardModel]
}

// MARK: - QuizReviewMapper
final class QuizReviewCardMapper: QuizReviewMapperProtocol {
    func map(session: QuizSessionEntity) -> [QuizReviewCardModel] {
        return session.questionsArray.map {
            QuizReviewCardModel(
                question: $0.questionText ?? "",
                answers: QuestionEntity.decodeAnswers($0.answers),
                correctIndex: Int($0.correctAnswerIndex),
                selectedIndex: Int($0.selectedAnswerIndex)
            )
        }
    }
}
