import UIKit

protocol QuizRouterProtocol {
    func attach(navigationController: UINavigationController?)
    func goBack()
    func goToResultScreen(with id: Int)
}

final class QuizRouter: QuizRouterProtocol {
    private weak var navigationController: UINavigationController?
}

extension QuizRouter {
    func attach(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func goToResultScreen(with id: Int) {
        let assembly = ResultAssembly()
        let resultsVC = assembly.makeScreen(with: id)
        navigationController?.pushViewController(resultsVC, animated: true)
    }
}
