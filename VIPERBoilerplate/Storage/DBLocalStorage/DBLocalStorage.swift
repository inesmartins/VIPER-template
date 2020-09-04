import Foundation

protocol DBLocalStorage {
    func storeObject<T>(_ object: T) -> Bool
    func loadFirstObject<T: Codable>() -> T?
    func loadAllObjects<T: Codable>() -> [T]?
}
