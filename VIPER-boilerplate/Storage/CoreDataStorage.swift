//
//  CoreDataStorage.swift
//  VIPER-boilerplate
//
//  Created by Inês Martins on 03/09/2020.
//  Copyright © 2020 Inês Martins. All rights reserved.
//

import Foundation

final class CoreDataStorage: LocalStorage {

    func store<T: Codable>(object: T, withKey key: String, encrypted: Bool) -> Bool {
        return false
    }

    func load<T: Codable>(key: String) -> T? {
        fatalError("Not implemented")
    }

}
