import Foundation

final class QuizAssembley {
    func makeScreen(with questions: [QuestionModel]) -> QuizViewController {
        let coreData = CoreDataManager()
        let date = Date()
        let router = QuizRouter()
        let viewModel = QuizViewModel(questions: questions,
                                      coreDataManager: coreData,
                                      date: date)
        return QuizViewController(viewModel: viewModel,
        router: router)
    }
}
