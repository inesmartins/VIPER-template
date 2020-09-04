import Foundation
import CoreData

final class CoreDataStorage: DBLocalStorage {

    private let context: NSManagedObjectContext = {
        let container = NSPersistentContainer(name: "VIPERBoilerplate")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container.viewContext
    }()

    // MARK: - CoreData Entities

    private let countryEntityName = "CountryEntity"
    private lazy var countryEntity = NSEntityDescription.entity(forEntityName: self.countryEntityName, in: self.context)

    // MARK: - Store/Load Data

    func storeObject<T>(_ object: T) -> Bool {
        if let country = object as? Country {
            guard let countryEntity = self.countryEntity else { return false }
            let newCountry = NSManagedObject(entity: countryEntity, insertInto: self.context)
            newCountry.setValue(country.name, forKey: Country.CodingKeys.name.rawValue)
            newCountry.setValue(country.code, forKey: Country.CodingKeys.code.rawValue)
        }
        return self.saveContext()
    }

    func loadFirstObject<T: Codable>() -> T? {
        if T.self == Country.self {
            return self.loadFirstCountry() as? T
        }
        return nil
    }

    func loadAllObjects<T: Codable>() -> [T]? {
        if T.self == Country.self {
            return self.loadAllCountries() as? [T]
        }
        return nil
    }

    // MARK: - Helper Methods

    private func loadAllCountries() -> [Country]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: self.countryEntityName)
        request.returnsObjectsAsFaults = false
        do {
            guard let result = try context.fetch(request) as? [NSManagedObject] else { return nil }
            var parsedCountries = [Country]()
            for data in result {
                if let countryName = data.value(forKey: Country.CodingKeys.name.rawValue) as? String,
                    let countryCode = data.value(forKey: Country.CodingKeys.code.rawValue) as? String {
                    let parsedCountry = Country(name: countryName, code: countryCode)
                    parsedCountries.append(parsedCountry)
                }
            }
            return parsedCountries
        } catch {
            return nil
        }
    }

    private func loadFirstCountry() -> Country? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: self.countryEntityName)
        request.returnsObjectsAsFaults = false
        do {
            guard let result = try context.fetch(request) as? [NSManagedObject] else { return nil }
            if result.count > 0 {
                if let countryName = result[0].value(forKey: Country.CodingKeys.name.rawValue) as? String,
                    let countryCode = result[0].value(forKey: Country.CodingKeys.code.rawValue) as? String {
                    return Country(name: countryName, code: countryCode)
                }
            }
            return nil
        } catch {
            return nil
        }
    }

    private func saveContext () -> Bool {
        if self.context.hasChanges {
            do {
                try context.save()
                return true
            } catch {
                return false
            }
        }
        return true
    }
}
