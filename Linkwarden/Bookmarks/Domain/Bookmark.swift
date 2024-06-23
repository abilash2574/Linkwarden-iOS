//
//  Bookmark.swift
//  Linkwarden
//
//  Created by Abilash S on 19/04/24.
//

import UIKit

class Bookmark: ObservableObject {
    
    var bookmarkID: Int64
    @Published var name: String
    var type: String
    var description: String
    var collectionID: Int64
    var URL: URL
    var previewURL: String
    @Published var previewImage: UIImage?
    var imageURL: String
    var pdfURL: String
    var readableURL: String
    var preservedDate: Date?
    var createdDate: Date
    var updatedDate: Date
    var tags: [Int64]
    
    init(bookmarkID: Int64, name: String, type: String, description: String, collectionID: Int64, URL: URL, previewURL: String, imageURL: String, pdfURL: String, readableURL: String, preservedDate: Date, createdDate: Date, updatedDate: Date, tags: [Int64]) {
        self.bookmarkID = bookmarkID
        self.name = name
        self.type = type
        self.description = description
        self.collectionID = collectionID
        self.URL = URL
        self.previewURL = previewURL
        self.imageURL = imageURL
        self.pdfURL = pdfURL
        self.readableURL = readableURL
        self.preservedDate = preservedDate
        self.createdDate = createdDate
        self.updatedDate = updatedDate
        self.tags = tags
    }
    
}

extension Bookmark: Hashable {
    
    static func == (lhs: Bookmark, rhs: Bookmark) -> Bool {
        lhs.bookmarkID == rhs.bookmarkID && lhs.type == rhs.type && lhs.URL == rhs.URL
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(bookmarkID)
        hasher.combine(type)
        hasher.combine(URL)
    }
}

extension Bookmark: Identifiable { }

extension Bookmark {
    static func getMockData() -> Bookmark {
        return .init(bookmarkID: 1, name: "Test Domain", type: "URL", description: "Example site", collectionID: 1, URL: .init(string: "www.example.com")!, previewURL: "", imageURL: "", pdfURL: "", readableURL: "", preservedDate: Date(), createdDate: Date(), updatedDate: Date(), tags: [])
    }
}
