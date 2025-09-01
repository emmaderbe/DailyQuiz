import UIKit

protocol QuizReviewRouterProtocol {
    func attach(navigationController: UINavigationController?)
    func goBack()
}

final class QuizReviewRouter: QuizReviewRouterProtocol {
    private weak var navigationController: UINavigationController?
}

extension QuizReviewRouter {
    func attach(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func goBack() {
        navigationController?.popToRootViewController(animated: true)
    }
}
