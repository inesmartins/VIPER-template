import Foundation
import UIKit

protocol AuthenticationRouterType {
    func startModule()
}

protocol AuthenticationPresenterToRouterDelegate: AnyObject {
    func onAuthenticationSucceeded()
}

final class AuthenticationRouter {

    private let appViewController: AppViewControllerType?
    private let routerDelegate: AuthRouterToAppRouterDelegate?
    private let authService: AuthServiceType?

    init(appViewController: AppViewControllerType,
         authService: AuthServiceType,
         routerDelegate: AuthRouterToAppRouterDelegate) {
        self.appViewController = appViewController
        self.authService = authService
        self.routerDelegate = routerDelegate
    }

}

extension AuthenticationRouter: AuthenticationRouterType {

    func startModule() {
        guard let authService = self.authService else {
            assertionFailure("authService should be present in \(self)")
            return
        }
        let authView = self.makeAuthenticationViewController(authService: authService)
        let navVC = UINavigationController.init(rootViewController: authView)
        self.appViewController?.updateCurrent(to: navVC)
    }
}

extension AuthenticationRouter: AuthenticationPresenterToRouterDelegate {

    func onAuthenticationSucceeded() {
        self.routerDelegate?.routeToHome()
    }

}

private extension AuthenticationRouter {

    func makeAuthenticationViewController(authService: AuthServiceType) -> AuthenticationViewController {
        let interactor = AuthenticationInteractor(authService: authService)
        let presenter = AuthenticationPresenter(interactorDelegate: interactor, routerDelegate: self)
        interactor.delegate = presenter
        return AuthenticationViewController(delegate: presenter)
    }

}
