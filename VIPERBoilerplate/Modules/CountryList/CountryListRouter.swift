import Foundation

protocol CountryListRouterProtocol: AnyObject {
    func makeCountryList() -> CountryListViewController
}

final class CountryListRouter {

    private let storageService: StorageServiceProtocol

    init(storageService: StorageServiceProtocol) {
        self.storageService = storageService
    }

}

extension CountryListRouter: CountryListRouterProtocol {

    func makeCountryList() -> CountryListViewController {
        let interactor = CountryListInteractor(storageService: self.storageService)
        let presenter = CountryListPresenter(interactor)
        return CountryListViewController(presenter)
    }
}
