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

    func store<T>(object: T, withKey key: String) -> Bool {
        self.defaults.set(Data(from: object), forKey: key)
        return true
    }

    func load<T: Codable>(key: String) -> T? {
        guard let data = self.defaults.data(forKey: key) else { return nil }
        return data.to(type: T.self)
    }

}
