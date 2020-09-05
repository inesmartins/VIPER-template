import Foundation
import UIKit

protocol AuthenticationRouterDelegate: class {
    func showAuthenticationPage(onRootViewController rootViewController: UINavigationController)
}

final class AuthenticationRouter: AuthenticationRouterDelegate {

    private weak var routerDelegate: AppRouterDelegate?
    private var rootViewController: UINavigationController?

    init(routerDelegate: AppRouterDelegate) {
        self.routerDelegate = routerDelegate
    }

    func showAuthenticationPage(onRootViewController rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
        self.rootViewController?.pushViewController(self.makeAuthenticationViewController(), animated: true)
    }

    private func makeAuthenticationViewController() -> AuthenticationViewController {
        let interactor = AuthenticationInteractor()
        let presenter = AuthenticationPresenter(interactor, routerDelegate: self)
        return AuthenticationViewController(presenter: presenter)
    }

}
