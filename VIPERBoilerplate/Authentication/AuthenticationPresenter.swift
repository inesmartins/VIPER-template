import Foundation

protocol AuthenticationPresenterDelegate: class {
    func didClickLoginButton(username: String, password: String)
}

final class AuthenticationPresenter: AuthenticationPresenterDelegate {

    private weak var interactor: AuthenticationInteractorDelegate?
    private var router: AuthenticationRouterDelegate?

    init(_ interactor: AuthenticationInteractorDelegate, routerDelegate: AuthenticationRouterDelegate) {
        self.interactor = interactor
        self.router = routerDelegate
    }

    func didClickLoginButton(username: String, password: String) {
        self.interactor?.validateLogin(username, password) { authenticated in
        }
    }

}
