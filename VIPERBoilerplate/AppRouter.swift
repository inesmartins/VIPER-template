import UIKit
import Foundation

protocol AppRouterDelegate: AnyObject {
    func showHome()
}

final class AppRouter: AppRouterDelegate {

    private let window: UIWindow
    private let rootViewController = UINavigationController()
    private var homeRouter: HomeRouter?

    init(window: UIWindow) {
        self.window = window
    }

    func launchApplication() {
        self.window.rootViewController = self.rootViewController
        self.homeRouter = HomeRouter(routerDelegate: self)
        self.homeRouter?.showHome(onRootViewController: self.rootViewController)
        self.window.makeKeyAndVisible()
    }

    func showHome() {
        self.rootViewController.popToRootViewController(animated: true)
    }

}
