//
//  Session+Extension.swift
//  Linkwarden
//
//  Created by Abilash S on 31/03/24.
//

import Foundation
import CoreData

extension Session {
    
    private static var context: NSManagedObjectContext { DataManager.shared.context }
    private static var entityName = "Session"
    
    static func getSession() -> Session? {
        do {
            guard let sessions = try context.fetch(.init(entityName: entityName)) as? [Session] else { return nil }
            return sessions.first
        } catch {
            LLogger.shared.error("Couldn't fetch sessions")
            return nil
        }
    }
    
    static func deleteSession() {
        do {
            guard let sessions = try context.fetch(.init(entityName: entityName)) as? [Session] else { return }
            for session in sessions {
                context.delete(session)
            }
            try context.save()
        } catch {
            LLogger.shared.error("Couldn't fetch sessions")
        }
    }
    
}
