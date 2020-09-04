import Foundation

protocol KeyValueLocalStorage {
    func store<T>(object: T, withKey key: String) -> Bool
    func load<T: Codable>(key: String) -> T?
}
