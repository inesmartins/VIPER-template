import Foundation

protocol CountryListRouterDelegate: AnyObject {
    func makeCountryList() -> CountryListViewController
}

final class CountryListRouter {

    private let storageService: StorageServiceDelegate

    init(storageService: StorageServiceDelegate) {
        self.storageService = storageService
    }

}

extension CountryListRouter: CountryListRouterDelegate {

    func makeCountryList() -> CountryListViewController {
        let interactor = CountryListInteractor(storageService: self.storageService)
        let presenter = CountryListPresenter(interactor)
        return CountryListViewController(presenter)
    }
}
