//
//  LocalStore.swift
//  VIPER-boilerplate
//
//  Created by Inês Martins on 03/09/2020.
//  Copyright © 2020 Inês Martins. All rights reserved.
//

import Foundation

enum Store {
    case NSUserDefaults
    case Keychain
    case TextFile
    case CoreData
    case Realm
    case SQLite
}
