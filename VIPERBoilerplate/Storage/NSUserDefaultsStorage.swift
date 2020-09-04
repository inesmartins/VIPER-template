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
