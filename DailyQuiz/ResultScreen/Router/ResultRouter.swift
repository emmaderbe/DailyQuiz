import UIKit

protocol ResultRouterProtocol {
    func attach(navigationController: UINavigationController?)
    func goBack()
}

final class ResultRouter: ResultRouterProtocol {
    private weak var navigationController: UINavigationController?
}

extension ResultRouter {
    func attach(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func goBack() {
        navigationController?.popToRootViewController(animated: true)
    }
}
