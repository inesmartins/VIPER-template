import Foundation

protocol AuthenticationInteractorProtocol: AnyObject {

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

extension AuthenticationInteractor: AuthenticationInteractorProtocol {

    func validateLogin(
        _ username: String,
        _ password: String,
        onCompletion: @escaping ((_ authenticated: Bool) -> Void)) {

        self.authService.validateLogin(username, password) { success in
            onCompletion(success)
        }
    }

}
