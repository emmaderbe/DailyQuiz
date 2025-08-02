import Foundation

// MARK: - Models
struct QuizResponse: Decodable {
    let results: [QuestionResponse]
}

struct QuestionResponse: Decodable {
    let difficulty: String
    let category: String
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]

    enum CodingKeys: String, CodingKey {
        case category
        case difficulty
        case question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}
