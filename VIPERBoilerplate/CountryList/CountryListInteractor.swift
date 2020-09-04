//
//  CountryInterceptor.swift
//  VIPER-boilerplate
//
//  Created by Inês Martins on 02/09/2020.
//  Copyright © 2020 Inês Martins. All rights reserved.
//

import Foundation

protocol CountryListInteractorDelegate: AnyObject {
    func loadCountryList() -> [Country]?
    func storeCountry(onStore: Store, _ country: Country, onCompletion: @escaping ((_ result: Bool) -> Void))
    func loadStoredCountry(from: Store, onCompletion: @escaping ((_ country: Country?) -> Void))
}

final class CountryListInteractor: CountryListInteractorDelegate {

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
                onCompletion(CoreDataStorage().store(object: country, withKey: key))
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
                return onCompletion(CoreDataStorage().load(key: key))
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
