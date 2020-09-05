import Foundation
import Security

class KeyChainStorage: KeyValueLocalStorage {

    private class SecKey {
        static let itemClass = kSecClass as String
        static let genericPasswordClass = kSecClassGenericPassword as String
        static let itemAccountName = kSecAttrAccount as String
        static let itemData = kSecValueData as String
        static let shouldReturnData = kSecReturnData as String
        static let trueBoolean = kCFBooleanTrue!
        static let matchLimit = kSecMatchLimit as String
        static let matchOne = kSecMatchLimitOne
    }

    func store<T>(object: T, withKey key: String) -> Bool {

        let data = Data(from: object)
        let query = [
            SecKey.itemClass: SecKey.genericPasswordClass,
            SecKey.itemAccountName: key,
            SecKey.itemData: data
        ] as CFDictionary

        // removes previous entry
        let deleteStatus = SecItemDelete(query)
        guard deleteStatus == noErr || deleteStatus == errSecItemNotFound else { return false }

        // adds new entry
        let addStatus = SecItemAdd(query, nil)
        guard addStatus == errSecSuccess else { return false }
        return true
    }

    func load<T>(key: String) -> T? {

        let query = [
            SecKey.itemClass: SecKey.genericPasswordClass,
            SecKey.itemAccountName: key,
            SecKey.shouldReturnData: SecKey.trueBoolean,
            SecKey.matchLimit: SecKey.matchOne
        ] as CFDictionary

        var dataTypeRef: AnyObject?
        let loadStatus: OSStatus = SecItemCopyMatching(query, &dataTypeRef)
        guard loadStatus == errSecSuccess else { return nil }
        guard let data = dataTypeRef as? Data else { return nil }
        return data.to(type: T.self)
    }

}
