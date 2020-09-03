//
//  CountryInterceptor.swift
//  VIPER-boilerplate
//
//  Created by Inês Martins on 02/09/2020.
//  Copyright © 2020 Inês Martins. All rights reserved.
//

import Foundation

protocol CountryListInteractorDelegate: AnyObject {
    func loadCountryList(onCompletion: @escaping ((_ countries: [Country]?) -> Void))
}

final class CountryListInteractor: CountryListInteractorDelegate {

    func loadCountryList(onCompletion: @escaping ((_ countries: [Country]?) -> Void)) {
        DispatchQueue.global(qos: .background).async {
            if let filepath = Bundle.main.path(forResource: "CountryList", ofType: "json") {
                do {
                    if let data = try String(contentsOfFile: filepath).data(using: .utf8) {
                        let decodedData = try JSONDecoder().decode([Country].self, from: data)
                        onCompletion(decodedData)
                    }
                } catch {
                    onCompletion(nil)
                }
            }
            onCompletion(nil)
        }
    }

}
