import Foundation

protocol CountryListRouterDelegate: class {
    func makeCountryList() -> CountryListViewController
}

final class CountryListRouter {
}

extension CountryListRouter: CountryListRouterDelegate {

    func makeCountryList() -> CountryListViewController {
        let interactor = CountryListInteractor()
        let presenter = CountryListPresenter(interactor)
        return CountryListViewController(presenter)
    }
}
