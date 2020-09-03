//
//  LocalStorage.swift
//  VIPER-boilerplate
//
//  Created by Inês Martins on 03/09/2020.
//  Copyright © 2020 Inês Martins. All rights reserved.
//

import Foundation

protocol LocalStorage {
    func store<T>(object: T, withKey key: String) -> Bool
    func load<T: Codable>(key: String) -> T?
}
