//
//  CountryInterceptor.swift
//  VIPER-boilerplate
//
//  Created by Inês Martins on 02/09/2020.
//  Copyright © 2020 Inês Martins. All rights reserved.
//

import Foundation

protocol CountryListInteractorDelegate: AnyObject {
    func loadCountryList()  -> [Country]?
    func storeCountry(on: Store, _ country: Country, onCompletion: @escaping ((_ result: Bool) -> Void))
    func loadStoredCountry(from: Store, onCompletion: @escaping ((_ country: Country?) -> Void))
}

final class CountryListInteractor: CountryListInteractorDelegate {
    
    func loadCountryList()  -> [Country]? {
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

    func storeCountry(on store: Store, _ country: Country, onCompletion: @escaping ((Bool) -> Void)) {
        DispatchQueue.global(qos: .background).async {
            switch store {
            case .NSUserDefaults:
                onCompletion(NSUserDefaultsStorage().store(
                    object: country,
                    withKey: AppKey.selectedCountry.rawValue,
                    encrypted: true))
            case .Keychain:
                onCompletion(KeyChainStorage().store(
                    object: country,
                    withKey: AppKey.selectedCountry.rawValue,
                    encrypted: true))
            case .CoreData:
                fatalError("Not implemented")
            case .Realm:
                fatalError("Not implemented")
            case .TextFile:
                fatalError("Not implemented")
            case .SQLite:
                fatalError("Not implemented")
            }
        }
    }

    func loadStoredCountry(from store: Store, onCompletion: @escaping ((_ country: Country?) -> Void)) {
        DispatchQueue.global(qos: .background).async {
            switch store {
            case .NSUserDefaults:
                return onCompletion(NSUserDefaultsStorage().load(key: AppKey.selectedCountry.rawValue))
            case .Keychain:
                return onCompletion(KeyChainStorage().load(key: AppKey.selectedCountry.rawValue))
            case .CoreData:
                fatalError("Not implemented")
            case .Realm:
                fatalError("Not implemented")
            case .TextFile:
                fatalError("Not implemented")
            case .SQLite:
                fatalError("Not implemented")
            }
        }
    }

}
