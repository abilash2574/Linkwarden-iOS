//
//  BookmarksModel.swift
//  Linkwarden
//
//  Created by Abilash S on 19/04/24.
//

import Foundation

struct BookmarksListJsonBody: Codable {
    
    var response: [BookmarksModel]
    
}

struct BookmarksJsonBody: Codable {
    var response: BookmarksModel
}

struct BookmarksModel: Codable {
    
    var bookmarkID: Int64
    var name: String
    var type: String
    var description: String
    var collectionID: Int64
    var url: String
    var previewURL: String?
    var imageURL: String?
    var pdfURL: String?
    var readableURL: String?
    var preservedDate: String?
    var createdDate: String
    var updatedDate: String
    var tags: [TagsModel]
    
    enum CodingKeys: String, CodingKey {
        case bookmarkID = "id"
        case name
        case type
        case description
        case collectionID = "collectionId"
        case url
        case previewURL = "preview"
        case imageURL = "image"
        case pdfURL = "pdf"
        case readableURL = "readable"
        case preservedDate = "lastPreserved"
        case createdDate = "createdAt"
        case updatedDate = "updatedAt"
        case tags
    }
    
    init(bookmarkID: Int64, name: String, type: String, description: String, collectionID: Int64, url: String, previewURL: String, imageURL: String, pdfURL: String, readableURL: String, preservedDate: String, createdDate: String, updatedDate: String, tags: [TagsModel]) {
        self.bookmarkID = bookmarkID
        self.name = name
        self.type = type
        self.description = description
        self.collectionID = collectionID
        self.url = url
        self.previewURL = previewURL
        self.imageURL = imageURL
        self.pdfURL = pdfURL
        self.readableURL = readableURL
        self.preservedDate = preservedDate
        self.createdDate = createdDate
        self.updatedDate = updatedDate
        self.tags = tags
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.bookmarkID = try container.decode(Int64.self, forKey: .bookmarkID)
        self.name = try container.decode(String.self, forKey: .name)
        self.type = try container.decode(String.self, forKey: .type)
        self.description = try container.decode(String.self, forKey: .description)
        self.collectionID = try container.decode(Int64.self, forKey: .collectionID)
        self.url = try container.decode(String.self, forKey: .url)
        self.previewURL = try container.decodeIfPresent(String.self, forKey: .previewURL)
        self.imageURL = try container.decodeIfPresent(String.self, forKey: .imageURL)
        self.pdfURL = try container.decodeIfPresent(String.self, forKey: .pdfURL)
        self.readableURL = try container.decodeIfPresent(String.self, forKey: .readableURL)
        self.preservedDate = try container.decodeIfPresent(String.self, forKey: .preservedDate)
        self.createdDate = try container.decode(String.self, forKey: .createdDate)
        self.updatedDate = try container.decode(String.self, forKey: .updatedDate)
        self.tags = try container.decode([TagsModel].self, forKey: .tags)
    }
    
}

struct BookmarkPostModel: Codable {
    var name: String
    var url: String
    var description: String
    var type: String = "url"
    var tags: [Tags]
    var collection: Collections
        
    struct Tags: Codable {
        let name: String
    }
    
    struct Collections: Codable {
        let name: String
    }
}

