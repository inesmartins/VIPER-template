import Foundation

protocol AuthenticationInteractorDelegate: class {

    func validateLogin(
        _ username: String,
        _ password: String,
        onCompletion: @escaping ((_ authenticated: Bool) -> Void))
}

final class AuthenticationInteractor: AuthenticationInteractorDelegate {

    func validateLogin(
        _ username: String,
        _ password: String,
        onCompletion: @escaping ((_ authenticated: Bool) -> Void)) {
        // TODO: implement authentication system
        onCompletion(true)
    }

}
