//
//  TagsModel.swift
//  Linkwarden
//
//  Created by Abilash S on 19/04/24.
//

import Foundation

// {"id":3, "name":"emacs", "ownerId":2, "createdAt":"2024-03-24T06:13:41.002Z", "updatedAt":"2024-03-24T06:13:41.002Z", "_count":{"links":5}}

struct TagsJsonBody: Codable {
    
    var response: [TagsModel]
    
}

struct TagsModel: Codable {
    
    struct LinkCount: Codable {
        var links: Int64
    }
    
    var tagID: Int64
    var name: String
    var ownerID: Int64
    var createdDate: String
    var updatedDate: String
    var linkCount: LinkCount?
    
    enum CodingKeys: String, CodingKey {
        case tagID = "id"
        case name
        case ownerID = "ownerId"
        case createdDate = "createdAt"
        case updatedDate = "updatedAt"
        case linkCount = "_count"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.tagID = try container.decode(Int64.self, forKey: .tagID)
        self.name = try container.decode(String.self, forKey: .name)
        self.ownerID = try container.decode(Int64.self, forKey: .ownerID)
        self.createdDate = try container.decode(String.self, forKey: .createdDate)
        self.updatedDate = try container.decode(String.self, forKey: .updatedDate)
        self.linkCount = try container.decodeIfPresent(LinkCount.self, forKey: .linkCount)
    }
}
