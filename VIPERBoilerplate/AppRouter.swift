import UIKit
import Foundation

protocol AppRouterDelegate: class {
}

final class AppRouter: AppRouterDelegate {

    private let rootViewController = UINavigationController()
    private var authenticationRouter: AuthenticationRouter?

    func launchApplication(onWindow window: UIWindow) {
        window.rootViewController = self.rootViewController
        self.authenticationRouter = AuthenticationRouter(routerDelegate: self)
        self.authenticationRouter?.showAuthenticationPage(onRootViewController: self.rootViewController)
        window.makeKeyAndVisible()
    }

}
