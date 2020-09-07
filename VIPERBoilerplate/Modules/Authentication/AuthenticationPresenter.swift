import Foundation

protocol AuthenticationPresenterType {}

protocol AuthenticationViewToPresenterDelegate: AnyObject {
    func didClickLoginButton(on view: AuthenticationViewControllerType, username: String, password: String)
}

protocol AuthenticationInteractorToPresenterDelegate: AnyObject {
    func onAuthenticationSucceeded()
    func onAuthenticationFailed()
}

final class AuthenticationPresenter {

    private var interactorDelegate: AuthenticationPresenterToInteractorDelegate
    private weak var routerDelegate: AuthenticationPresenterToRouterDelegate?
    private weak var view: AuthenticationViewControllerType?

    init(interactorDelegate: AuthenticationPresenterToInteractorDelegate, routerDelegate: AuthenticationPresenterToRouterDelegate) {
        self.interactorDelegate = interactorDelegate
        self.routerDelegate = routerDelegate
    }

}

extension AuthenticationPresenter: AuthenticationPresenterType {}

extension AuthenticationPresenter: AuthenticationViewToPresenterDelegate {

    func didClickLoginButton(on view: AuthenticationViewControllerType, username: String, password: String) {
        self.view = view
        self.interactorDelegate.validateLogin(username, password)
    }
}

extension AuthenticationPresenter: AuthenticationInteractorToPresenterDelegate {

    func onAuthenticationSucceeded() {
        self.routerDelegate?.onAuthenticationSucceeded()
    }
    
    func onAuthenticationFailed() {
        self.view?.showAuthenticationError()
    }
    
    
}
