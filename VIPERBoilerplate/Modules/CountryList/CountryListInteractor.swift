import Foundation

protocol CountryListInteractorProtocol: AnyObject {
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

    private let storageService: StorageServiceProtocol

    init(storageService: StorageServiceProtocol) {
        self.storageService = storageService
    }
}

extension CountryListInteractor: CountryListInteractorProtocol {

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
        self.storageService.save(object: country, withKey: AppKey.selectedCountry.rawValue, inStore: store) { result in
            do {
                onCompletion(try result.get())
            } catch let error {
                #if DEBUG
                debugPrint(error)
                #endif
                onCompletion(false)
            }
        }
    }

    func loadStoredCountry(from store: Store, onCompletion: @escaping ((_ country: Country?) -> Void)) {
        let key = AppKey.selectedCountry.rawValue
        self.storageService.load(fromStore: store, withKey: key) { (result: Result<Country?, Error>) in
            do {
                onCompletion(try result.get())
            } catch let error {
                #if DEBUG
                print(error)
                #endif
                onCompletion(nil)
            }
        }
    }

}
