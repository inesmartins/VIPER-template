import UIKit
import Foundation

protocol AppRouterType: AnyObject {
    func startApplication()
}

protocol AuthenticationRouterToAppRouterDelegate: AnyObject {
    func routeToHome()
}

protocol HomeRouterToAppRouterDelegate: AnyObject {}

final class AppRouter {

    private var store: StoreServiceType
    private var authService: AuthServiceType
    private var ddgService: DDGServiceType
    private var appViewController: AppViewControllerType

    private var authRouter: AuthenticationRouter?
    private var homeRouter: HomeRouter?
    
    init(appViewController: AppViewControllerType,
         store: StoreServiceType,
         authService: AuthServiceType,
         ddgService: DDGServiceType) {

        self.appViewController = appViewController
        self.store = store
        self.authService = authService
        self.ddgService = ddgService
    }
}

extension AppRouter: AppRouterType {

    func startApplication() {
        self.routeToAuthentication()
    }
}

extension AppRouter: AuthenticationRouterToAppRouterDelegate {
    
    func routeToHome() {
        self.homeRouter = HomeRouter(
            appViewController: self.appViewController,
            store: store,
            ddgService: ddgService,
            delegate: self)
        self.homeRouter?.startModule()
    }
}

extension AppRouter: HomeRouterToAppRouterDelegate {}

private extension AppRouter {

    func routeToAuthentication() {
        self.authRouter = AuthenticationRouter(appViewController: self.appViewController,
                                               authService: self.authService,
                                               delegate: self)
        self.authRouter?.startModule()
    }

}
