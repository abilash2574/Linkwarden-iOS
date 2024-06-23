//
//  BookmarksAddFormFields.swift
//  Linkwarden
//
//  Created by Abilash S on 23/06/24.
//

import Foundation

enum BookmarksAddFormFields {
    case url
    case title
    case description
    case tags
    case collection
}

extension BookmarksAddFormFields: CaseIterable {}

extension BookmarksAddFormFields {
    
    var displayName: LocalizedStringResource {
        switch self {
            case .url:
                return "URL"
            case .title:
                return "Name"
            case .description:
                return "Description"
            case .tags:
                return "Tags"
            case .collection:
                return "Collection"
        }
    }
    
}
