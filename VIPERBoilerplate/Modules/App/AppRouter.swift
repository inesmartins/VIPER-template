import UIKit
import Foundation

protocol AppRouterType: AnyObject {
    func startApplication()
}

protocol AuthRouterToAppRouterDelegate: AnyObject {
    func routeToHome()
}

protocol HomeRouterToAppRouterDelegate: AnyObject {}

final class AppRouter {

    private var store: StoreServiceType
    private var apiService: APIServiceType
    private var appViewController: AppViewControllerType

    private var authRouter: AuthenticationRouter?
    private var homeRouter: HomeRouter?

    init(appViewController: AppViewControllerType,
         store: StoreServiceType,
         apiService: APIServiceType) {

        self.appViewController = appViewController
        self.store = store
        self.apiService = apiService
    }
}

extension AppRouter: AppRouterType {

    func startApplication() {
        self.routeToAuthentication()
    }
}

extension AppRouter: AuthRouterToAppRouterDelegate {

    func routeToHome() {
        self.homeRouter = HomeRouter(appViewController: self.appViewController,
                                     store: self.store,
                                     homeService: self.apiService,
                                     delegate: self)
        self.homeRouter?.startModule()
    }
}

extension AppRouter: HomeRouterToAppRouterDelegate {}

private extension AppRouter {

    func routeToAuthentication() {
        self.authRouter = AuthenticationRouter(appViewController: self.appViewController,
                                               authService: self.apiService,
                                               routerDelegate: self)
        self.authRouter?.startModule()
    }

}
