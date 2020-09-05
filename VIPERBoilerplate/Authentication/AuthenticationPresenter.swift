import Foundation

protocol AuthenticationPresenterDelegate: class {
    func didClickLoginButton(onView view: AuthenticationViewController, username: String, password: String)
}

final class AuthenticationPresenter: AuthenticationPresenterDelegate {
    
    private var interactor: AuthenticationInteractorDelegate?
    private var router: AuthenticationRouterDelegate?
    
    init(_ interactor: AuthenticationInteractorDelegate, router: AuthenticationRouterDelegate) {
        self.interactor = interactor
        self.router = router
    }
    
    func didClickLoginButton(onView view: AuthenticationViewController, username: String, password: String) {
        self.interactor?.validateLogin(username, password) { authenticated in
            guard authenticated else {
                view.showAuthenticationError()
                return
            }
            self.router?.showHomeScreen()
        }
    }
}
