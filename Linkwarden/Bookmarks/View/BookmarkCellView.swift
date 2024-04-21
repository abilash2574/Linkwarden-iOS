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
                .foregroundStyle(ThemeManager.secondaryLabel)
                .frame(maxWidth: 64, maxHeight: 64)
                .clipShape(.rect(cornerRadius: 4))

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
            
        }.padding(.init(top: 6, leading: 12, bottom: 6, trailing: 12))
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
    
    var imageValue: Image {
        switch labelType {
        case .domain:
            ImageConstants.domainIcon
        case .collection:
            ImageConstants.folderIcon
        case .date:
            ImageConstants.calendarIcon
        }
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            if labelType == .domain {
                imageValue
                    .renderingMode(.template)
                    .resizable()
                    .imageScale(.small)
                    .foregroundStyle(ThemeManager.secondaryLabel)
                    .frame(maxWidth: 18, maxHeight: 10)
            } else {
                imageValue
                    .renderingMode(.template)
                    .imageScale(.small)
                    .foregroundStyle(ThemeManager.secondaryLabel)
            }
            Text(labelText)
                .truncationMode(.tail)
                .lineLimit(1)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(ThemeManager.secondaryLabel)
        }
    }
}

#Preview {
    let model = Bookmark.getMockData()
    
    return BookmarkCellView(bookmark: model)
        .background(.gray.opacity(0.20))
}
