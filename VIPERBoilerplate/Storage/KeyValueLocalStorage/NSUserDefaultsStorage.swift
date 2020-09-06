import Foundation

final class NSUserDefaultsStorage {
    let defaults = UserDefaults.standard
}

extension NSUserDefaultsStorage: KeyValueLocalStorage {
    
    func store<T: Codable>(object: T, withKey key: String) throws {
        self.defaults.set(Data(from: object), forKey: key)
    }

    func value<T: Codable>(forKey key: String) throws -> T? {
        guard let data = self.defaults.data(forKey: key),
            let object = data.to(type: T.self) else {
            return nil
        }
        return object
    }

}
