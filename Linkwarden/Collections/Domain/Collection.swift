//
//  Collection.swift
//  Linkwarden
//
//  Created by Abilash S on 27/04/24.
//

import Foundation

class Collection: ObservableObject {
    
    var collectionID: Int64
    @Published var name: String
    var description: String
    var color: String
    var parentID: Int64?
    var isPublic: Bool
    var ownerID: Int64
    @Published var createdDate: Date
    var updatedDate: Date
    var count: Int64
    
    init(collectionID: Int64, name: String, description: String, color: String, parentID: Int64? = nil, isPublic: Bool, ownerID: Int64, createdDate: Date, updatedDate: Date, count: Int64) {
        self.collectionID = collectionID
        self.name = name
        self.description = description
        self.color = color
        self.parentID = parentID
        self.isPublic = isPublic
        self.ownerID = ownerID
        self.createdDate = createdDate
        self.updatedDate = updatedDate
        self.count = count
    }
}
