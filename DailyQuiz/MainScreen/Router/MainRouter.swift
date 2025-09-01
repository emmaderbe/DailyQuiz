import UIKit


protocol MainRouterProtocol: AnyObject {
    func attach(navigationController: UINavigationController?)
    func goToHistoryScreen()
    func goToQuizScreen(with questions: [QuestionModel])
}

final class MainRouter: MainRouterProtocol {
    private weak var navigationController: UINavigationController?
}

extension MainRouter {
    func attach(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func goToQuizScreen(with questions: [QuestionModel]) {
        let assembly = QuizAssembley()
        let quizVC = assembly.makeScreen(with: questions)
        navigationController?.pushViewController(quizVC, animated: true)
    }
    
    func goToHistoryScreen() {
        let historyScreenAssembly = HistoryScreenAssembly()
        let historyVC = historyScreenAssembly.makeHistoryScreen()
        navigationController?.pushViewController(historyVC,
                                                 animated: true)
    }
}
