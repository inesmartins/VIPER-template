import Foundation
import UIKit

protocol AuthenticationRouterProtocol: AnyObject {
    func showAuthenticationScreen(onRootViewController rootViewController: UINavigationController)
    func showHomeScreen()
}

final class AuthenticationRouter {

    private var storeService: StoreService
    private var delegate: AppRouterDelegate?
    private var rootViewController: UINavigationController?

    init(storeService: StoreService, appRouter: AppRouterDelegate) {
        self.storeService = storeService
        self.delegate = appRouter
    }

}

extension AuthenticationRouter: AuthenticationRouterProtocol {

    func showAuthenticationScreen(onRootViewController rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
        self.rootViewController?.pushViewController(self.makeAuthenticationViewController(), animated: true)
    }

    func showHomeScreen() {
        self.delegate?.showHomeScreen()
    }

}

private extension AuthenticationRouter {

    func makeAuthenticationViewController() -> AuthenticationViewController {
        let interactor = AuthenticationInteractor(authService: authService)
        let presenter = AuthenticationPresenter(interactor: interactor, router: self)
        return AuthenticationViewController(presenter: presenter)
    }

}
