import Foundation
import UIKit

protocol HomeRouterDelegate: class {
    func showHome(onRootViewController rootViewController: UINavigationController)
    func showDeviceInfo()
    func showCountryList()
}

final class HomeRouter {

    private weak var routerDelegate: AppRouterDelegate?
    private var rootViewController: UINavigationController?

    init(routerDelegate: AppRouterDelegate) {
        self.routerDelegate = routerDelegate
    }

}

extension HomeRouter: HomeRouterDelegate {

    func showHome(onRootViewController rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
        self.rootViewController?.clearViewControllerStack()
        self.rootViewController?.pushViewController(self.makeHomeViewController(), animated: true)
    }

    func showDeviceInfo() {
        self.rootViewController?.pushViewController(DeviceInfoRouter().makeDeviceInfo(), animated: true)
    }

    func showCountryList() {
        self.rootViewController?.pushViewController(CountryListRouter().makeCountryList(), animated: true)
    }

}

private extension HomeRouter {

    func makeHomeViewController() -> HomeViewController {
        let interactor = HomeInteractor()
        let presenter = HomePresenter(interactor, routerDelegate: self)
        return HomeViewController(presenter)
    }
}
