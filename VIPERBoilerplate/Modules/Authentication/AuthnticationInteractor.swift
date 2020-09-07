import Foundation

protocol AuthenticationInteractorType {}

protocol AuthenticationPresenterToInteractorDelegate: AnyObject {
    func validateLogin(_ username: String, _ password: String)
}

final class AuthenticationInteractor {

    private let authService: AuthServiceType
    weak var delegate: AuthenticationInteractorToPresenterDelegate?

    init(authService: AuthServiceType) {
        self.authService = authService
    }
}

extension AuthenticationInteractor: AuthenticationInteractorType {}

extension AuthenticationInteractor: AuthenticationPresenterToInteractorDelegate {

    func validateLogin(_ username: String, _ password: String) {
        self.authService.validateLogin(username, password) { success in
            if success {
                self.delegate?.onAuthenticationSucceeded()
            } else {
                self.delegate?.onAuthenticationFailed()
            }
        }
    }

}
