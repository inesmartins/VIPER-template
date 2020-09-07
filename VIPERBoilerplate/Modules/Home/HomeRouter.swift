import Foundation
import UIKit

typealias HomeServiceType = DDGServiceType

protocol HomeRouterType {
    func startModule()
}

protocol HomePresenterToRouterDelegate: AnyObject {
    func showDDGSearch()
    func showCountryList()
}

protocol CountryListRouterToHomeRouterDelegate: AnyObject {}
protocol DDGSearchRouterToHomeRouterDelegate: AnyObject {}

final class HomeRouter {

    private weak var appViewController: AppViewControllerType?
    private weak var navigationController: UINavigationController?

    private weak var store: StoreServiceType?
    private weak var homeService: HomeServiceType?
    private weak var delegate: HomeRouterToAppRouterDelegate?

    init(appViewController: AppViewControllerType,
         store: StoreServiceType,
         homeService: HomeServiceType,
         delegate: HomeRouterToAppRouterDelegate) {
        self.appViewController = appViewController
        self.store = store
        self.homeService = homeService
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

    func showDDGSearch() {
        guard let ddgService = self.homeService else {
            assertionFailure("ddgService should be present in \(self)")
            return
        }
        let ddgSearchView = self.makeDDGSearchViewController(ddgService: ddgService)
        self.navigationController?.pushViewController(ddgSearchView, animated: true)
    }

    func showCountryList() {
        guard let store = self.store else {
            assertionFailure("ddgService should be present in \(self)")
            return
        }
        let countryListView = self.makeCountryListViewController(store: store)
        self.navigationController?.pushViewController(countryListView, animated: true)
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

    func makeDDGSearchViewController(ddgService: DDGServiceType) -> DDGSearchViewController {
        let interactor = DDGSearchInteractor(ddgService: ddgService)
        let presenter = DDGSearchPresenter(interactor)
        return DDGSearchViewController(presenter)
    }

    func makeCountryListViewController(store: StoreServiceType) -> CountryListViewController {
        let interactor = CountryListInteractor(store: store)
        let presenter = CountryListPresenter(interactor)
        interactor.delegate = presenter
        return CountryListViewController(presenter)
    }
}
