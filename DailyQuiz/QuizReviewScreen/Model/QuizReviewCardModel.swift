import Foundation

struct QuizReviewCardModel {
    let question: String
    let answers: [String]
    let correctIndex: Int
    let selectedIndex: Int?
    
    var isCorrect: Bool {
        return correctIndex == selectedIndex
    }
}
