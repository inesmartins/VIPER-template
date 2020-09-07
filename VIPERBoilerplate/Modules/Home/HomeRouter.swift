import Foundation
import UIKit

protocol HomeRouterType {
    func startModule()
}

protocol HomePresenterToRouterDelegate: AnyObject {
    func showDeviceInfo()
    func showCountryList()
}

protocol CountryListRouterToHomeRouterDelegate: AnyObject {}
protocol DDGSearchRouterToHomeRouterDelegate: AnyObject {}

final class HomeRouter {

    private weak var appViewController: AppViewControllerType?
    private weak var navigationController: UINavigationController?

    private weak var store: StoreServiceType?
    private weak var ddgService: DDGServiceType?
    private weak var delegate: HomeRouterToAppRouterDelegate?

    init(appViewController: AppViewControllerType,
         store: StoreServiceType,
         ddgService: DDGServiceType,
         delegate: HomeRouterToAppRouterDelegate) {
        
        self.appViewController = appViewController
        self.store = store
        self.ddgService = ddgService
        self.delegate = delegate
    }

}

extension HomeRouter: HomeRouterType {

    func startModule() {
        let homeView = self.makeHomeViewController()
        let navigationController = UINavigationController(rootViewController: homeView)
        self.navigationController = navigationController
        self.appViewController?.updateCurrent(to: navigationController)
    }

}

extension HomeRouter: HomePresenterToRouterDelegate {
    
    func showDeviceInfo() {
        guard let appVC = self.appViewController, let ddgService = self.ddgService else {
            assertionFailure("store should be present on HomeRouter")
            return
        }
        DDGSearchRouter(appViewController: appVC, ddgService: ddgService, delegate: self).startModule()
    }

    func showCountryList() {
        guard let appVC = self.appViewController, let store = self.store else {
            assertionFailure("store should be present on HomeRouter")
            return
        }
        CountryListRouter(appViewController: appVC, store: store).startModule()
    }
}

extension HomeRouter: DDGSearchRouterToHomeRouterDelegate {}
extension HomeRouter: CountryListRouterToHomeRouterDelegate {}

private extension HomeRouter {

    func makeHomeViewController() -> HomeViewController {
        let interactor = HomeInteractor()
        let presenter = HomePresenter(interactorDelegate: interactor, routerDelegate: self)
        return HomeViewController(presenter)
    }
}
