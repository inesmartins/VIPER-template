//
//  UserDefaultsStorage.swift
//  VIPER-boilerplate
//
//  Created by Inês Martins on 03/09/2020.
//  Copyright © 2020 Inês Martins. All rights reserved.
//

import Foundation

final class NSUserDefaultsStorage: LocalStorage {
    
    let defaults = UserDefaults.standard

    func store<T: Codable>(object: T, withKey key: String, encrypted: Bool) -> Bool {
        self.defaults.set(object, forKey: key)
        return true
    }

    func load<T: Codable>(key: String) -> T? {
        fatalError("Not implemented")
    }

}
