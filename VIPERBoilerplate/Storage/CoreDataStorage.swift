//
//  CoreDataStorage.swift
//  VIPER-boilerplate
//
//  Created by Inês Martins on 03/09/2020.
//  Copyright © 2020 Inês Martins. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataStorage: LocalStorage {

    let container = NSPersistentContainer(name: "CoreDataDemo")
    lazy var persistentContainer: NSPersistentContainer = {
        self.container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    lazy var context = self.persistentContainer.viewContext
    lazy var countryEntity = NSEntityDescription.entity(forEntityName: "Country", in: self.context)

    func store<T>(object: T, withKey key: String) -> Bool {
        guard let countryEntity = self.countryEntity else { return false }
        let newCountry = NSManagedObject(entity: countryEntity, insertInto: context)
        // TODO: set values
        return self.saveContext()
    }

    func load<T: Codable>(key: String) -> T? {
        fatalError("Not implemented")
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
