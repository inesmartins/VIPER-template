import UIKit
import Foundation

protocol AppRouterDelegate: class {
    func showHomeScreen()
}

final class AppRouter: AppRouterDelegate {

    private let rootViewController = UINavigationController()
    private var authenticationRouter: AuthenticationRouter?
    private var homeRouter: HomeRouter?

    func launchApplication(onWindow window: UIWindow) {
        window.rootViewController = self.rootViewController
        self.authenticationRouter = AuthenticationRouter(routerDelegate: self)
        self.authenticationRouter?.showAuthenticationScreen(onRootViewController: self.rootViewController)
        window.makeKeyAndVisible()
    }

    func showHomeScreen() {
        self.homeRouter = HomeRouter(routerDelegate: self)
        self.homeRouter?.showHome(onRootViewController: self.rootViewController)
    }

}
