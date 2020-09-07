import Foundation
import UIKit

protocol HomeRouterProtocol: AnyObject {
    func showHome(onRootViewController rootViewController: UINavigationController)
    func showDeviceInfo()
    func showCountryList()
}

final class HomeRouter {

    private var appRouter: AppRouterDelegate?
    private let storageService: StorageServiceProtocol
    private let ddgService: DuckDuckGoServiceProtocol

    private var rootViewController: UINavigationController?

    init(storageService: StorageServiceProtocol,
         ddgService: DuckDuckGoServiceProtocol,
         appRouter: AppRouterDelegate) {
        self.appRouter = appRouter
        self.ddgService = ddgService
        self.storageService = storageService
    }

}

extension HomeRouter: HomeRouterProtocol {

    func showHome(onRootViewController rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
        self.rootViewController?.clearViewControllerStack()
        self.rootViewController?.pushViewController(self.makeHomeViewController(), animated: true)
    }

    func showDeviceInfo() {
        let ddgRouter = DDGSearchRouter(ddgService: self.ddgService)
        self.rootViewController?.pushViewController(ddgRouter.makeDeviceInfo(), animated: true)
    }

    func showCountryList() {
        let countryInfoRouter = CountryListRouter(storageService: self.storageService)
        self.rootViewController?.pushViewController(countryInfoRouter.makeCountryList(), animated: true)
    }

}

private extension HomeRouter {

    func makeHomeViewController() -> HomeViewController {
        let interactor = HomeInteractor()
        let presenter = HomePresenter(interactor, router: self)
        return HomeViewController(presenter)
    }
}
