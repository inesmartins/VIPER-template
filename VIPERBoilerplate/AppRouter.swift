import UIKit
import Foundation

protocol AppRouterDelegate: AnyObject {
    func showHomeScreen()
}

final class AppRouter {

    // MARK: - Services
    private let storeService = StoreService()

    // MARK: - Routers
    private var authenticationRouter: AuthenticationRouter?
    private var homeRouter: HomeRouter?

    private let rootViewController = UINavigationController()

    func launchApplication(onWindow window: UIWindow) {
        window.rootViewController = self.rootViewController
        self.authenticationRouter = AuthenticationRouter(authService: self.storeService, appRouter: self)
        self.authenticationRouter?.showAuthenticationScreen(onRootViewController: self.rootViewController)
        window.makeKeyAndVisible()
    }

}

extension AppRouter: AppRouterDelegate {

    func showHomeScreen() {
        self.homeRouter = HomeRouter(storeService: self.storeService, appRouter: self)
        self.homeRouter?.showHome(onRootViewController: self.rootViewController)
    }

}
