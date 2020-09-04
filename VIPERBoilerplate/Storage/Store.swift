//
//  LocalStore.swift
//  VIPER-boilerplate
//
//  Created by Inês Martins on 03/09/2020.
//  Copyright © 2020 Inês Martins. All rights reserved.
//

import Foundation

enum Store: String, CaseIterable {

    case userDefaults = "NSUserDefaults"
    case keychain = "KeyChain"
    case coreData = "Core Data"
    case textFile = "Text file"
    case sqlLite = "SQLite Database"
    case realm = "Realm"
}
