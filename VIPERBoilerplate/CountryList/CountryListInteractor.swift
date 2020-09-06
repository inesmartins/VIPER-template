import Foundation

protocol CountryListInteractorDelegate: class {
    func loadCountryList() -> [Country]?
    func storeCountry(onStore: Store, _ country: Country, onCompletion: @escaping ((_ result: Bool) -> Void))
    func loadStoredCountry(from: Store, onCompletion: @escaping ((_ country: Country?) -> Void))
}

final class CountryListInteractor {
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

    func storeCountry(onStore store: Store, _ country: Country, onCompletion: @escaping ((Bool) -> Void)) {
        let key = AppKey.selectedCountry.rawValue
        DispatchQueue.global(qos: .background).async {
            switch store {
            case .userDefaults:
                onCompletion(NSUserDefaultsStorage().store(object: country, withKey: key))
            case .keychain:
                onCompletion(KeyChainStorage().store(object: country, withKey: key))
            case .coreData:
                onCompletion(CoreDataStorage().storeObject(country))
            case .textFile:
                fatalError("Not implemented")
            case .sqlLite:
                fatalError("Not implemented")
            case .realm:
                fatalError("Not implemented")
            }
        }
    }

    func loadStoredCountry(from store: Store, onCompletion: @escaping ((_ country: Country?) -> Void)) {
        let key = AppKey.selectedCountry.rawValue
        DispatchQueue.global(qos: .background).async {
            switch store {
            case .userDefaults:
                return onCompletion(NSUserDefaultsStorage().load(key: key))
            case .keychain:
                return onCompletion(KeyChainStorage().load(key: key))
            case .coreData:
                return onCompletion(CoreDataStorage().loadFirstObject())
            case .textFile:
                fatalError("Not implemented")
            case .sqlLite:
                fatalError("Not implemented")
            case .realm:
                fatalError("Not implemented")
            }
        }
    }

}
