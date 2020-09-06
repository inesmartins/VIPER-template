import Foundation

protocol KeyValueLocalStorage {
    func store<T: Codable>(object: T, withKey key: String) throws
    func value<T: Codable>(forKey: String) throws -> T?
}
