//
//  UserConvertor.swift
//  Linkwarden
//
//  Created by Abilash S on 28/04/24.
//

import Foundation

class UserConvertor {
    
    func convertUserModelToUser(_ user: UserModel) -> User? {
        
        guard let createdDate = DateTimeManager.defaultDateFormatter.dateFormatter.date(from: user.createdDate), let updatedDate = DateTimeManager.defaultDateFormatter.dateFormatter.date(from: user.updatedDate) else { return nil }
        
        let user = User(userID: user.userID, displayName: user.name, username: user.username, openLinkAction: user.openLinkAction, preventDuplication: user.archivePDF, archiveScreenshot: user.archiveScreenshot, archivePDF: user.archivePDF, archiveWaybackMachine: user.archiveWaybackMachine, privateProfile: user.privateProfile, createdDate: createdDate, updatedDate: updatedDate)
        
        return user
        
    }
    
}
