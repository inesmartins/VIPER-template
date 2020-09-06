import Foundation

protocol CountryListInteractorDelegate: class {
    func loadCountryList() -> [Country]?
    func storeCountry(
        inStore store: Store,
        _ country: Country,
        onCompletion: @escaping ((_ result: Bool) -> Void))
    func loadStoredCountry(
        from: Store,
        onCompletion: @escaping ((_ country: Country?) -> Void))
}

final class CountryListInteractor {

    private let storage = StorageService()
}

extension CountryListInteractor: CountryListInteractorDelegate {

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

    func storeCountry(inStore store: Store, _ country: Country, onCompletion: @escaping ((Bool) -> Void)) {
        self.storage.save(object: country, withKey: AppKey.selectedCountry.rawValue, inStore: store) { result in
            do {
                onCompletion(try result.get())
            } catch let error {
                #if DEBUG
                debugPrint(error.localizedDescription)
                #endif
                onCompletion(false)
            }
        }
    }

    func loadStoredCountry(from store: Store, onCompletion: @escaping ((_ country: Country?) -> Void)) {
        let key = AppKey.selectedCountry.rawValue
        self.storage.load(fromStore: store, withKey: key) { (result: Result<Country?, Error>) in
            do {
                onCompletion(try result.get())
            } catch let error {
                #if DEBUG
                print(error.localizedDescription)
                #endif
                onCompletion(nil)
            }
        }
    }

}
