import Foundation

protocol CountryListRouterType {
    func startModule()
}

final class CountryListRouter {

    private weak var appViewController: AppViewControllerType?
    private let store: StoreServiceType

    init(appViewController: AppViewControllerType, store: StoreServiceType) {
        self.appViewController = appViewController
        self.store = store
    }

}

extension CountryListRouter: CountryListRouterType {

    func startModule() {
        self.appViewController?.updateCurrent(to: self.makeCountryList())
    }
}

private extension CountryListRouter {

    func makeCountryList() -> CountryListViewController {
        let interactor = CountryListInteractor(store: self.store)
        let presenter = CountryListPresenter(interactor)
        return CountryListViewController(presenter)
    }
}
