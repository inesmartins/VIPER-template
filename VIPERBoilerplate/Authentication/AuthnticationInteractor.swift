import Foundation

protocol AuthenticationInteractorDelegate: class {

    func validateLogin(
        _ username: String,
        _ password: String,
        onCompletion: @escaping ((_ authenticated: Bool) -> Void))
}

final class AuthenticationInteractor {
}

extension AuthenticationInteractor: AuthenticationInteractorDelegate {

    func validateLogin(
        _ username: String,
        _ password: String,
        onCompletion: @escaping ((_ authenticated: Bool) -> Void)) {

        AuthenticationService.validateLogin(username, password) { success in
            onCompletion(success)
        }
    }

}
