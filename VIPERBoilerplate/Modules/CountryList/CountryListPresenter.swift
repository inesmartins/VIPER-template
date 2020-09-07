import Foundation

protocol CountryListPresenterType {}

protocol CountryListViewToPresenterDelegate: AnyObject {
    func viewWasLoaded(on view: CountryListViewControllerType)
    func didSelectCountry(_ country: Country)
    func didSelectStore(_ store: Store)
    func didClickSaveCountry()
    func didClickLoadSavedCountry()
}

protocol CountryListInteractorToPresenterDelegate: AnyObject {
    func didSaveCountry()
    func errorWhileSavingCountry(_ error: Error)
    func didLoadCountry(_ country: Country)
    func errorWhileLoadingCountry()
}

final class CountryListPresenter {

    private var interactorDelegate: CountryListPresenterToInteractorDelegate?
    private weak var view: CountryListViewControllerType?
    private var selectedCountry: Country?
    private var selectedStore = Store.allCases[0]

    init(_ interactorDelegate: CountryListPresenterToInteractorDelegate) {
        self.interactorDelegate = interactorDelegate
    }
}

extension CountryListPresenter: CountryListPresenterType {}

extension CountryListPresenter: CountryListViewToPresenterDelegate {

    func viewWasLoaded(on view: CountryListViewControllerType) {
        self.view = view
        if let countries = self.interactorDelegate?.loadCountryList() {
            self.view?.updateCountryList(countries)
        }
    }

    func didSelectCountry(_ country: Country) {
        self.selectedCountry = country
    }

    func didSelectStore(_ store: Store) {
        self.selectedStore = store
    }

    func didClickSaveCountry() {
        if let selectedCountry = self.selectedCountry {
            self.interactorDelegate?.storeCountry(inStore: self.selectedStore, selectedCountry)
        }
    }

    func didClickLoadSavedCountry() {
        self.interactorDelegate?.loadStoredCountry(from: self.selectedStore)
    }

}

extension CountryListPresenter: CountryListInteractorToPresenterDelegate {

    func didSaveCountry() {
        self.view?.showSaveResult(true)
    }

    func errorWhileSavingCountry(_ error: Error) {
        self.view?.showSaveResult(false)
    }

    func didLoadCountry(_ country: Country) {
        self.view?.showSavedCountry(country)
    }

    func errorWhileLoadingCountry() {
        // TODO: show error
    }

}
