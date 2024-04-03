//
//  Module.swift
//  Linkwarden
//
//  Created by Abilash S on 01/04/24.
//

import Foundation
import SwiftUI

enum Module: Identifiable {
    
    case Favourites
    case Bookmarks
    case Tags
    case Collections
    case Settings
    
    var id: String {
        switch self {
        case .Favourites:
            "favourites.tag"
        case .Bookmarks:
            "bookmarks.tag"
        case .Tags:
            "tags.tag"
        case .Collections:
            "collections.tag"
        case .Settings:
            "settings.tag"
        }
    }
    
    var displayName: String {
        switch self {
        case .Favourites:
            "Favourites"
        case .Bookmarks:
            "Bookmarks"
        case .Tags:
            "Tags"
        case .Collections:
            "Collections"
        case .Settings:
            "Settings"
        }
    }
    
    var tabIcon: Image {
        switch self {
        case .Favourites:
            ImageConstants.favouriteIcon
        case .Bookmarks:
            ImageConstants.bookmarksIcon
        case .Tags:
            ImageConstants.tagsIcon
        case .Collections:
            ImageConstants.collectionsIcon
        case .Settings:
            ImageConstants.settingsIcon
        }
    }
    
}
