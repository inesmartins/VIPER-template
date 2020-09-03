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
    func storeCountry(_ country: Country, onCompletion: @escaping ((_ result: Bool) -> Void))
    func loadStoredCountry(onCompletion: @escaping ((_ country: Country?) -> Void))
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

    func storeCountry(_ country: Country, onCompletion: @escaping ((Bool) -> Void)) {
        DispatchQueue.global(qos: .background).async {
            onCompletion(KeyChainStorage().store(object: country, withKey: KeyChainStorage.AppKey.selectedCountry.rawValue, encrypted: true))
        }
    }

    func loadStoredCountry(onCompletion: @escaping ((_ country: Country?) -> Void)) {
        DispatchQueue.global(qos: .background).async {
            onCompletion(KeyChainStorage().load(key: KeyChainStorage.AppKey.selectedCountry.rawValue))
        }
    }

}
