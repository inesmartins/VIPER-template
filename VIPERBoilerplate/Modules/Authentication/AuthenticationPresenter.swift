import Foundation

protocol AuthenticationPresenterDelegate: AnyObject {
    func didClickLoginButton(on view: AuthenticationViewControllerDelegate, username: String, password: String)
}

final class AuthenticationPresenter {

    private var interactor: AuthenticationInteractorDelegate?
    private var router: AuthenticationRouterDelegate?

    init(interactor: AuthenticationInteractorDelegate, router: AuthenticationRouterDelegate) {
        self.interactor = interactor
        self.router = router
    }

}

extension AuthenticationPresenter: AuthenticationPresenterDelegate {

    func didClickLoginButton(on view: AuthenticationViewControllerDelegate, username: String, password: String) {
        self.interactor?.validateLogin(username, password) { authenticated in
            guard authenticated else {
                view.showAuthenticationError()
                return
            }
            self.router?.showHomeScreen()
        }
    }
}
