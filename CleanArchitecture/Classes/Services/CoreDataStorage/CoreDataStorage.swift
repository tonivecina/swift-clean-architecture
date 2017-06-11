//
//  CoreDataStorage.swift
//  CleanArchitecture
//
//  Created by Toni Vecina on 6/11/17.
//  Copyright © 2017 Toni Vecina. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataStorage {

    fileprivate func managedContext() throws -> NSManagedObjectContext {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            throw DataError.fail(detail: "Context unavailable.")
        }

        return appDelegate.persistentContainer.viewContext
    }

    func save() throws {
        try managedContext().save()
    }
}

extension CoreDataStorage {

    public enum DataError: Error {
        case fail(detail: String)
    }
}

extension CoreDataStorage {

    func newEntity<T: NSManagedObject>(_ entity: T.Type) throws -> T {
        let entityName = T.description()
        let context = try managedContext()

        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
            throw DataError.fail(detail: "Entity unavailable.")
        }

        return T(entity: entity, insertInto: context)
    }

    func fetchResults<T: NSManagedObject>(_ entity: T.Type) throws -> [T] {
        let context = try managedContext()

        return try context.fetch(T.fetchRequest()) as! [T]
    }

}
