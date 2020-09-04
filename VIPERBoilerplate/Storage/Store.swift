import Foundation

enum Store: String, CaseIterable {

    case userDefaults = "NSUserDefaults"
    case keychain = "KeyChain"
    case coreData = "Core Data"
    case textFile = "Text file"
    case sqlLite = "SQLite Database"
    case realm = "Realm"
}
