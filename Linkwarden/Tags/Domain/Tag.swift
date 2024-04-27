//
//  Tag.swift
//  Linkwarden
//
//  Created by Abilash S on 25/04/24.
//

import Foundation

class Tag: ObservableObject {
    
    var tagID: Int64
    @Published var name: String
    var ownerID: Int64
    @Published var createdDate: Date
    var updatedDate: Date
    @Published var linkCount: Int64
 
    init(tagID: Int64, name: String, ownerID: Int64, createdDate: Date, updatedDate: Date, linkCount: Int64) {
        self.tagID = tagID
        self.name = name
        self.ownerID = ownerID
        self.createdDate = createdDate
        self.updatedDate = updatedDate
        self.linkCount = linkCount
    }
    
}

extension Tag: Identifiable { }
