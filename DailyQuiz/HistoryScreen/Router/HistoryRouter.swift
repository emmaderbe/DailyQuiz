import UIKit

protocol HistoryRouterProtocol: AnyObject {
    func attach(navigationController: UINavigationController?)
    func goBack()
    func goToQuizReview(with id: Int)
}

final class HistoryRouter: HistoryRouterProtocol {
    private weak var navigationController: UINavigationController?
}

extension HistoryRouter {
    func attach(navigationController: UINavigationController?) {
            self.navigationController = navigationController
        }
    
    func goBack() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func goToQuizReview(with id: Int) {
        let assembly = QuizReviewAssembly()
        let vc = assembly.makeScreen(with: id)
        navigationController?.pushViewController(vc, animated: true)
    }
}
