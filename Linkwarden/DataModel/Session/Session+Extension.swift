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
    
    /// Retrives the session information from the database if they are available
    /// - Returns: Session information if available, or returns `nil`
    static func getSession() -> Session? {
        do {
            guard let sessions = try context.fetch(.init(entityName: entityName)) as? [Session] else { return nil }
            return sessions.first
        } catch {
            LLogger.shared.error("Couldn't fetch sessions")
            return nil
        }
    }
    
    /// Deletes the session information that have been stored in the DB
    static func deleteSession() async -> Bool {
        await context.perform {
            do {
                guard let sessions = try context.fetch(.init(entityName: entityName)) as? [Session] else { return false }
                for session in sessions {
                    context.delete(session)
                }
                try context.save()
                return true
            } catch {
                LLogger.shared.error("Couldn't fetch sessions")
                return false
            }
        }
    }
        
}
