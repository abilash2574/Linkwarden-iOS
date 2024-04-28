//
//  UserModel.swift
//  Linkwarden
//
//  Created by Abilash S on 28/04/24.
//

import Foundation

struct UserJsonBody: Codable {
    
    var response: UserModel
    
}

struct UserModel: Codable {
    
    var userID: Int64
    var name: String
    var username: String
    var openLinkAction: String
    var preventDuplication: Bool
    var archiveScreenshot: Bool
    var archivePDF: Bool
    var archiveWaybackMachine: Bool
    var privateProfile: Bool
    var createdDate: String
    var updatedDate: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "id"
        case name
        case username
        case openLinkAction = "linksRouteTo"
        case preventDuplication = "preventDuplicateLinks"
        case archiveScreenshot = "archiveAsScreenshot"
        case archivePDF = "archiveAsPDF"
        case archiveWaybackMachine = "archiveAsWaybackMachine"
        case privateProfile = "isPrivate"
        case createdDate = "createdAt"
        case updatedDate = "updatedAt"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userID = try container.decode(Int64.self, forKey: .userID)
        self.name = try container.decode(String.self, forKey: .name)
        self.username = try container.decode(String.self, forKey: .username)
        self.openLinkAction = try container.decode(String.self, forKey: .openLinkAction)
        self.preventDuplication = try container.decode(Bool.self, forKey: .preventDuplication)
        self.archiveScreenshot = try container.decode(Bool.self, forKey: .archiveScreenshot)
        self.archivePDF = try container.decode(Bool.self, forKey: .archivePDF)
        self.archiveWaybackMachine = try container.decode(Bool.self, forKey: .archiveWaybackMachine)
        self.privateProfile = try container.decode(Bool.self, forKey: .privateProfile)
        self.createdDate = try container.decode(String.self, forKey: .createdDate)
        self.updatedDate = try container.decode(String.self, forKey: .updatedDate)
    }
    
}
