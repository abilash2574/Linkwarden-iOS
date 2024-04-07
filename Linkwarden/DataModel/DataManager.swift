//
//  DataManager.swift
//  Linkwarden
//
//  Created by Abilash S on 31/03/24.
//

import Foundation
import CoreData

class DataManager: ObservableObject {
    
    static let containerName =  "Linkwarden"
    
    static let shared = DataManager()
    
    let container = NSPersistentContainer(name: DataManager.containerName)
    
    var context: NSManagedObjectContext {
        container.viewContext
    }
    
    private init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                LLogger.shared.critical("Failed to load core data \(error)")
            }
        }
    }
}
