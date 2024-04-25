//
//  Tags.swift
//  Linkwarden
//
//  Created by Abilash S on 25/04/24.
//

import Foundation

class Tags {
    
    var tagsID: Int64
    var name: String
    var ownerID: Int64
    var createdDate: Date
    var updatedDate: Date
    var linkCount: Int64
 
    init(tagsID: Int64, name: String, ownerID: Int64, createdDate: Date, updatedDate: Date, linkCount: Int64) {
        self.tagsID = tagsID
        self.name = name
        self.ownerID = ownerID
        self.createdDate = createdDate
        self.updatedDate = updatedDate
        self.linkCount = linkCount
    }
    
}
