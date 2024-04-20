//
//  TagsModel.swift
//  Linkwarden
//
//  Created by Abilash S on 19/04/24.
//

import Foundation

struct TagsModel: Codable {
    var tagID: Int64
    var name: String
    var ownerID: Int64
    var createdDate: String
    var updatedDate: String
    
    enum CodingKeys: String, CodingKey {
        case tagID = "id"
        case name
        case ownerID = "ownerId"
        case createdDate = "createdAt"
        case updatedDate = "updatedAt"
        
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.tagID = try container.decode(Int64.self, forKey: .tagID)
        self.name = try container.decode(String.self, forKey: .name)
        self.ownerID = try container.decode(Int64.self, forKey: .ownerID)
        self.createdDate = try container.decode(String.self, forKey: .createdDate)
        self.updatedDate = try container.decode(String.self, forKey: .updatedDate)
    }
}
