import Foundation

final class CountryListRouter {

    func showCountryList() -> CountryListViewController {
        let interactor = CountryListInteractor()
        let presenter = CountryListPresenter(interactor)
        return CountryListViewController(presenter)
    }
}
