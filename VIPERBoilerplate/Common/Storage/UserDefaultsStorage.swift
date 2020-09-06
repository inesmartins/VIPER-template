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

    func store(data: Data, withKey key: String, encrypted: Bool) -> Bool {
        self.defaults.set(data, forKey: key)
        return true
    }

    func store(string: String, withKey key: String, encrypted: Bool) -> Bool {
        self.defaults.set(string, forKey: key)
        return true
    }

    func store(object: AnyObject, withKey key: String, encrypted: Bool) -> Bool {
        self.defaults.set(object, forKey: key)
        return true
    }

}
