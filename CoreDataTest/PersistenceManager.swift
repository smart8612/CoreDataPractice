//
//  PersistenceManager.swift
//  CoreDataTest
//
//  Created by JeongTaek Han on 2022/01/24.
//

import Foundation
import CoreData

class PersistenceManager {
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
}
