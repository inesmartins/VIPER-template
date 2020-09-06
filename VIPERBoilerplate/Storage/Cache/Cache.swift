import Foundation

final class Cache<Key: Hashable, Value> {

    private let cache = NSCache<WrappedKey, Entry>()
    private let dateProvider: () -> Date
    private let entryLifetime: TimeInterval
    private let keyTracker = KeyTracker()

    // To enable unit testing, we use dependency injection and so, instead of calling Date()
    // inside the initializer, we inject a Date-producing function
    // Also, we provide a entryLifetime property, with a default value of 12 hours
    init(dateProvider: @escaping () -> Date = Date.init,
         entryLifetime: TimeInterval = 12 * 60 * 60,
         maximumEntryCount: Int = 50) {
        self.dateProvider = dateProvider
        self.entryLifetime = entryLifetime
        self.cache.countLimit = maximumEntryCount
        self.cache.delegate = keyTracker
    }

}

// forces entries to adopt Codable when they have Codable keys and values
extension Cache.Entry: Codable where Key: Codable, Value: Codable {}

// forces Cache itself to adopt Codable when it has Codable keys and values
extension Cache: Codable where Key: Codable, Value: Codable {

    convenience init(from decoder: Decoder) throws {
        self.init()

        let container = try decoder.singleValueContainer()
        let entries = try container.decode([Entry].self)
        entries.forEach(insert)
    }

    // encodes any Codable Cache
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(keyTracker.keys.compactMap(entry))
    }
}

extension Cache where Key: Codable, Value: Codable {

    // saves any Codable Cache to disk by:
    // - encoding it into Data
    // - writing that data to a file within our app’s dedicated caching directory
    func saveToDisk(
        withName name: String,
        using fileManager: FileManager = .default
    ) throws {
        let folderURLs = fileManager.urls(
            for: .cachesDirectory,
            in: .userDomainMask
        )
        let fileURL = folderURLs[0].appendingPathComponent(name + ".cache")
        let data = try JSONEncoder().encode(self)
        try data.write(to: fileURL)
    }
}

// MARK: - Private Methods

private extension Cache {

    final class WrappedKey: NSObject {
        let key: Key
        init(_ key: Key) { self.key = key }
        override var hash: Int { return key.hashValue }
        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? WrappedKey else {
                return false
            }
            return value.key == key
        }
    }

    final class Entry {
        let key: Key
        let value: Value
        let expirationDate: Date

        init(key: Key, value: Value, expirationDate: Date) {
            self.key = key
            self.value = value
            self.expirationDate = expirationDate
        }
    }

    func insert(_ value: Value, forKey key: Key) {
        let date = dateProvider().addingTimeInterval(entryLifetime)
        let entry = Entry(key: key, value: value, expirationDate: date)
        self.cache.setObject(entry, forKey: WrappedKey(key))
        self.keyTracker.keys.insert(key)
    }

    func value(forKey key: Key) -> Value? {
        guard let entry = cache.object(forKey: WrappedKey(key)) else {
            return nil
        }
        guard dateProvider() < entry.expirationDate else {
            // Discard values that have expired
            self.removeValue(forKey: key)
            return nil
        }
        return entry.value
    }

    func removeValue(forKey key: Key) {
        self.cache.removeObject(forKey: WrappedKey(key))
    }

    subscript(key: Key) -> Value? {
        get { return value(forKey: key) }
        set {
            guard let value = newValue else {
                // If nil was assigned using our subscript,
                // then we remove any value for that key:
                self.removeValue(forKey: key)
                return
            }
            self.insert(value, forKey: key)
        }
    }
}

private extension Cache {

    // is notified whenever an entry is removed from NSCache and updates the "keys" Set accordingly
    final class KeyTracker: NSObject, NSCacheDelegate {
        var keys = Set<Key>()
        func cache(_ cache: NSCache<AnyObject, AnyObject>,
                   willEvictObject object: Any) {
            guard let entry = object as? Entry else {
                return
            }
            keys.remove(entry.key)
        }
    }
}

private extension Cache {

    // retrieves Entry from NSCache
    func entry(forKey key: Key) -> Entry? {
        guard let entry = cache.object(forKey: WrappedKey(key)) else {
            return nil
        }
        guard dateProvider() < entry.expirationDate else {
            removeValue(forKey: key)
            return nil
        }
        return entry
    }

    // adds Entry to NSCache and updates KeyTracker with new key
    func insert(_ entry: Entry) {
        self.cache.setObject(entry, forKey: WrappedKey(entry.key))
        self.keyTracker.keys.insert(entry.key)
    }
}
