//
//  LinkCellView.swift
//  Linkwarden
//
//  Created by Abilash S on 16/04/24.
//

import SwiftUI

struct BookmarkCellView: View {
    
    @Environment(\.dynamicTypeSize) var sizeCategory
    
    @ObservedObject
    var bookmark: Bookmark
    
    var body: some View {
        HStack(spacing: 16) {
            
            Image(uiImage: bookmark.previewImage!)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(.gray)
                .frame(maxWidth: 64, maxHeight: 64)
            
            VStack(alignment: .leading) {
                Text(bookmark.name.isEmpty ? bookmark.description : bookmark.name)
                    .font(.headline)
                    .lineLimit(1)
                CellLabel(labelText: bookmark.URL.host() ?? "Link not found", labelType: .domain)
                if sizeCategory > .xxLarge {
                    VStack(alignment: .leading) {
                        CellLabel(labelText: bookmark.collectionID.description, labelType: .collection)
                        CellLabel(labelText: DateTimeManager.mediumDate.dateFormatter.string(from: bookmark.createdDate), labelType: .date)
                    }
                } else {
                    HStack(spacing: 16) {
                        CellLabel(labelText: bookmark.collectionID.description, labelType: .collection)
                        CellLabel(labelText: DateTimeManager.mediumDate.dateFormatter.string(from: bookmark.createdDate), labelType: .date)
                    }
                }
            }
            
        }
    }
}

struct CellLabel: View {
    
    enum CellLabelType {
        case domain
        case collection
        case date
    }
    
    var labelText: String
    
    var labelType: CellLabelType
    
    var imageValue: String {
        switch labelType {
        case .domain:
            "link"
        case .collection:
            "folder.fill"
        case .date:
            "calendar"
        }
    }
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: imageValue)
                .imageScale(.small)
                .foregroundStyle(.gray)
            Text(labelText)
                .truncationMode(.tail)
                .lineLimit(1)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(.gray)
        }
    }
}
// TODO: ZVZV Provide mock data
//
//#Preview {
//    let model = BookmarkCellModel(linkName: "Google", domainText: "www.google.com", collectionText: "Search Engine", dateText: "23-11-2023", image: UIImage(systemName: "photo")!)
//    
//    return BookmarkCellView(cellModel: model)
//}
