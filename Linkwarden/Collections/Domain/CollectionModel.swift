//
//  CollectionModel.swift
//  Linkwarden
//
//  Created by Abilash S on 27/04/24.
//

import Foundation

// {"id":3,"name":"Gardening","description":"Plants and Garden materials","color":"#80ff00","parentId":null,"isPublic":false,"ownerId":1,"createdAt":"2024-04-27T11:06:37.016Z","updatedAt":"2024-04-27T11:06:37.016Z","parent":null,"members":[],"_count":{"links":0}}

struct CollectionsJsonBody: Codable {
    
    var response: [CollectionModel]
    
}

struct CollectionModel: Codable {
    
    struct LinkCount: Codable {
        var links: Int64
    }
    
    var collectionID: Int64
    var name: String
    var description: String
    var color: String
    var parentID: Int64?
    var isPublic: Bool
    var ownerID: Int64
    var createdDate: String
    var updatedDate: String
    var count: LinkCount
    
    enum CodingKeys: String, CodingKey {
        case collectionID = "id"
        case name
        case description
        case color
        case parentID = "parentId"
        case isPublic
        case ownerID = "ownerId"
        case createdDate = "createdAt"
        case updatedDate = "updatedAt"
        case count = "_count"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.collectionID = try container.decode(Int64.self, forKey: .collectionID)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        self.color = try container.decode(String.self, forKey: .color)
        self.parentID = try container.decodeIfPresent(Int64.self, forKey: .parentID)
        self.isPublic = try container.decode(Bool.self, forKey: .isPublic)
        self.ownerID = try container.decode(Int64.self, forKey: .ownerID)
        self.createdDate = try container.decode(String.self, forKey: .createdDate)
        self.updatedDate = try container.decode(String.self, forKey: .updatedDate)
        self.count = try container.decode(CollectionModel.LinkCount.self, forKey: .count)
    }
    
}
