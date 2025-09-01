import Foundation

final class QuizReviewAssembly {
    func makeScreen(with id:  Int) -> QuizReviewViewController {
        let coreData = CoreDataManager()
        let formatter = ResultFormatter()
        let mapper = QuizReviewCardMapper()
        let router = QuizReviewRouter()
        let viewModel = QuizReviewViewModel(coreDataManager: coreData,
                                            formatter: formatter,
                                            mapper: mapper,
                                            quizId: id)
        return QuizReviewViewController(viewModel: viewModel,
                                        router: router)
    }
}
