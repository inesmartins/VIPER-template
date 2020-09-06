import Foundation
import UIKit

protocol AuthenticationRouterDelegate: AnyObject {
    func showAuthenticationScreen(onRootViewController rootViewController: UINavigationController)
    func showHomeScreen()
}

final class AuthenticationRouter {

    private var authService: AuthenticationService
    private var router: AppRouterDelegate?
    private var rootViewController: UINavigationController?

    init(authService: AuthenticationService, appRouter: AppRouterDelegate) {
        self.authService = authService
        self.router = appRouter
    }

}

extension AuthenticationRouter: AuthenticationRouterDelegate {

    func showAuthenticationScreen(onRootViewController rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
        self.rootViewController?.pushViewController(self.makeAuthenticationViewController(), animated: true)
    }

    func showHomeScreen() {
        self.router?.showHomeScreen()
    }

}

private extension AuthenticationRouter {

    func makeAuthenticationViewController() -> AuthenticationViewController {
        let interactor = AuthenticationInteractor(authService: authService)
        let presenter = AuthenticationPresenter(interactor: interactor, router: self)
        return AuthenticationViewController(presenter: presenter)
    }

}
