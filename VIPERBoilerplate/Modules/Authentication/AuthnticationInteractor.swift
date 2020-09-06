import Foundation

protocol AuthenticationInteractorDelegate: AnyObject {

    func validateLogin(
        _ username: String,
        _ password: String,
        onCompletion: @escaping ((_ authenticated: Bool) -> Void))
}

final class AuthenticationInteractor {

    private let authService: AuthenticationService

    init(authService: AuthenticationService) {
        self.authService = authService
    }
}

extension AuthenticationInteractor: AuthenticationInteractorDelegate {

    func validateLogin(
        _ username: String,
        _ password: String,
        onCompletion: @escaping ((_ authenticated: Bool) -> Void)) {

        self.authService.validateLogin(username, password) { success in
            onCompletion(success)
        }
    }

}
