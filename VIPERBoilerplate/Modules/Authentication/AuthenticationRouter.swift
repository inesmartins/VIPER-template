import Foundation
import UIKit

protocol AuthenticationRouterType {
    func startModule()
}

protocol AuthenticationPresenterToRouterDelegate: AnyObject {
    func onAuthenticationSucceeded()
}

final class AuthenticationRouter {

    private weak var appViewController: AppViewControllerType?
    private weak var authService: AuthServiceType?
    private weak var delegate: AuthenticationRouterToAppRouterDelegate?

    init(appViewController: AppViewControllerType, authService: AuthServiceType, delegate: AuthenticationRouterToAppRouterDelegate) {
        self.appViewController = appViewController
        self.authService = authService
        self.delegate = delegate
    }

}

extension AuthenticationRouter: AuthenticationRouterType {

    func startModule() {
        guard let authService = self.authService else {
            assertionFailure("authService should be present in AuthInteractor")
            return
        }
        let authView = self.makeAuthenticationViewController(authService: authService)
        let navVC = UINavigationController.init(rootViewController: authView)
        self.appViewController?.updateCurrent(to: navVC)
    }
}

extension AuthenticationRouter: AuthenticationPresenterToRouterDelegate {

    func onAuthenticationSucceeded() {
        self.delegate?.routeToHome()
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
