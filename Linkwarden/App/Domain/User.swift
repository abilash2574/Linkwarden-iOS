//
//  User.swift
//  Linkwarden
//
//  Created by Abilash S on 28/04/24.
//

import Foundation

class User {
    
    var userID: Int64
    var displayName: String
    var username: String
    var openLinkAction: String
    var preventDuplication: Bool
    var archiveScreenshot: Bool
    var archivePDF: Bool
    var archiveWaybackMachine: Bool
    var privateProfile: Bool
    var createdDate: Date
    var updatedDate: Date
    
    var profileImage = ImageConstants.profileIcon
    
    init(userID: Int64, displayName: String, username: String, openLinkAction: String, preventDuplication: Bool, archiveScreenshot: Bool, archivePDF: Bool, archiveWaybackMachine: Bool, privateProfile: Bool, createdDate: Date, updatedDate: Date) {
        self.userID = userID
        self.displayName = displayName
        self.username = username
        self.openLinkAction = openLinkAction
        self.preventDuplication = preventDuplication
        self.archiveScreenshot = archiveScreenshot
        self.archivePDF = archivePDF
        self.archiveWaybackMachine = archiveWaybackMachine
        self.privateProfile = privateProfile
        self.createdDate = createdDate
        self.updatedDate = updatedDate
    }
    
}

extension User {
    static let mockUser = User(userID: 2, displayName: "Zeyrie", username: "route_64", openLinkAction: "Option", preventDuplication: false, archiveScreenshot: true, archivePDF: true, archiveWaybackMachine: true, privateProfile: false, createdDate: Date(), updatedDate: Date())
}
