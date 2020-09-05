import Foundation

protocol CountryListRouterDelegate {
    func makeCountryList() -> CountryListViewController
}

final class CountryListRouter: CountryListRouterDelegate {

    func makeCountryList() -> CountryListViewController {
        let interactor = CountryListInteractor()
        let presenter = CountryListPresenter(interactor)
        return CountryListViewController(presenter)
    }
}
