//
//  BookmarksConvertor.swift
//  Linkwarden
//
//  Created by Abilash S on 19/04/24.
//

import Foundation

class BookmarksConvertor {
        
    func convertBookmarksModelToBookmarks(_ models: [BookmarksModel]) -> [Bookmark] {
        var bookmarks = [Bookmark]()
        
        models.forEach { model in
            guard let url = URL(string: model.url) else { return }
            
            guard let createdDate = DateTimeManager.defaultDateFormatter.dateFormatter.date(from: model.createdDate), let updatedDate = DateTimeManager.defaultDateFormatter.dateFormatter.date(from: model.updatedDate) else {
                return
            }
            
            let tags = model.tags.map( { $0.tagID } )
            
            var preservedDate = Date()
            if let date = DateTimeManager.defaultDateFormatter.dateFormatter.date(from: model.preservedDate ?? "") {
                preservedDate = date
            }
            
            let bookmark = Bookmark(
                bookmarkID: model.bookmarkID,
                name: model.name,
                type: model.type,
                description: model.description,
                collectionID: model.collectionID,
                URL: url,
                previewURL: model.previewURL ?? "",
                imageURL: model.imageURL ?? "",
                pdfURL: model.pdfURL ?? "",
                readableURL: model.readableURL ?? "",
                preservedDate: preservedDate,
                createdDate: createdDate,
                updatedDate: updatedDate,
                tags: tags
            )
            
            bookmarks.append(bookmark)
        }
        
        return bookmarks
        
    }
    
}
