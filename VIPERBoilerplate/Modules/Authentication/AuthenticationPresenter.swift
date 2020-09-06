import Foundation

protocol AuthenticationPresenterProtocol: AnyObject {
    func didClickLoginButton(on view: AuthenticationViewControllerProtocol, username: String, password: String)
}

final class AuthenticationPresenter {

    private var interactor: AuthenticationInteractorProtocol?
    private var router: AuthenticationRouterProtocol?

    init(interactor: AuthenticationInteractorProtocol, router: AuthenticationRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }

}

extension AuthenticationPresenter: AuthenticationPresenterProtocol {

    func didClickLoginButton(on view: AuthenticationViewControllerProtocol, username: String, password: String) {
        self.interactor?.validateLogin(username, password) { authenticated in
            guard authenticated else {
                view.showAuthenticationError()
                return
            }
            self.router?.showHomeScreen()
        }
    }
}
