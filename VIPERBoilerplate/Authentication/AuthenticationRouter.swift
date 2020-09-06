import Foundation
import UIKit

protocol AuthenticationRouterDelegate: class {
    func showAuthenticationScreen(onRootViewController rootViewController: UINavigationController)
    func showHomeScreen()
}

final class AuthenticationRouter {

    private var appRouter: AppRouterDelegate?
    private var rootViewController: UINavigationController?

    init(routerDelegate: AppRouterDelegate) {
        self.appRouter = routerDelegate
    }

}

extension AuthenticationRouter: AuthenticationRouterDelegate {

    func showAuthenticationScreen(onRootViewController rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
        self.rootViewController?.pushViewController(self.makeAuthenticationViewController(), animated: true)
    }

    func showHomeScreen() {
        self.appRouter?.showHomeScreen()
    }

}

private extension AuthenticationRouter {

    func makeAuthenticationViewController() -> AuthenticationViewController {
        let interactor = AuthenticationInteractor()
        let presenter = AuthenticationPresenter(interactor, router: self)
        return AuthenticationViewController(presenter: presenter)
    }

}
