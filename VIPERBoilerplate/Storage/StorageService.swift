import Foundation

final class StorageService {

    let userDefaults = NSUserDefaultsStorage()
    let keychain = KeyChainStorage()
    let coreData = CoreDataStorage()

    func save<T: Codable>(object: T, withKey key: String, inStore store: Store,
                          onCompletion: @escaping (_ result: Result<Bool, Error>) -> Void) {

        DispatchQueue.global(qos: .background).async {
            do {
                switch store {
                case .cache:
                    let cache: Cache<String, T> = Cache()
                    cache.insert(object, forKey: key)
                    try cache.saveToDisk(withName: UUID().uuidString)
                    onCompletion(.success(true))
                case .userDefaults:
                    try self.userDefaults.store(object: object, withKey: key)
                    onCompletion(.success(true))
                case .keychain:
                    try self.keychain.store(object: object, withKey: key)
                    onCompletion(.success(true))
                case .coreData:
                    try self.coreData.storeObject(object)
                    onCompletion(.success(true))
                case .textFile:
                    onCompletion(.failure(NSError(domain: "Not implemented", code: 0, userInfo: nil)))
                case .sqlLite:
                    onCompletion(.failure(NSError(domain: "Not implemented", code: 0, userInfo: nil)))
                case .realm:
                    onCompletion(.failure(NSError(domain: "Not implemented", code: 0, userInfo: nil)))
                }
            } catch let error {
                onCompletion(.failure(error))
            }
        }
    }

    func load<T: Codable>(
        fromStore store: Store,
        withKey key: String,
        onCompletion: @escaping (_ result: Result<T?, Error>) -> Void) {

        DispatchQueue.global(qos: .background).async {
            do {
                switch store {
                case .cache:
                    let cache: Cache<String, T> = Cache()
                    onCompletion(.success(cache.value(forKey: key)))
                case .userDefaults:
                    onCompletion(.success(try self.userDefaults.value(forKey: key)))
                case .keychain:
                    onCompletion(.success(try self.keychain.value(forKey: key)))
                case .coreData:
                    onCompletion(.success(try self.coreData.loadFirstObject()))
                case .textFile:
                    onCompletion(.failure(NSError(domain: "Not implemented", code: 0, userInfo: nil)))
                case .sqlLite:
                    onCompletion(.failure(NSError(domain: "Not implemented", code: 0, userInfo: nil)))
                case .realm:
                    onCompletion(.failure(NSError(domain: "Not implemented", code: 0, userInfo: nil)))
                }
            } catch let error {
                onCompletion(.failure(error))
            }
        }
    }
}
