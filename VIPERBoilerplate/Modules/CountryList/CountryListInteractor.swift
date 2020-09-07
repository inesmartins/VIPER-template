import Foundation

protocol CountryListInteractorType {}

protocol CountryListPresenterToInteractorDelegate: AnyObject {
    func loadCountryList() -> [Country]?
    func storeCountry(inStore store: Store, _ country: Country)
    func loadStoredCountry(from: Store)
}

final class CountryListInteractor {

    private let store: StoreServiceType
    weak var delegate: CountryListInteractorToPresenterDelegate?

    init(store: StoreServiceType) {
        self.store = store
    }
}

extension CountryListInteractor: CountryListPresenterToInteractorDelegate {

    func loadCountryList() -> [Country]? {
        if let filepath = Bundle.main.path(forResource: "CountryList", ofType: "json") {
            do {
                if let data = try String(contentsOfFile: filepath).data(using: .utf8) {
                    let decodedData = try JSONDecoder().decode([Country].self, from: data)
                    return decodedData
                }
            } catch {
                return nil
            }
        }
        return nil
    }

    func storeCountry(inStore store: Store, _ country: Country) {
        self.store.save(object: country, withKey: AppKey.selectedCountry.rawValue, inStore: store) { result in
            do {
                _ = try result.get()
                self.delegate?.didSaveCountry()
            } catch let error {
                #if DEBUG
                debugPrint(error)
                #endif
                self.delegate?.errorWhileSavingCountry(error)
            }
        }
    }

    func loadStoredCountry(from store: Store) {
        let key = AppKey.selectedCountry.rawValue
        self.store.load(fromStore: store, withKey: key) { (result: Result<Country?, Error>) in
            do {
                if let country = try result.get() {
                    self.delegate?.didLoadCountry(country)
                } else {
                    self.delegate?.errorWhileLoadingCountry()
                }
            } catch let error {
                #if DEBUG
                print(error)
                #endif
                self.delegate?.errorWhileLoadingCountry()
            }
        }
    }

}
