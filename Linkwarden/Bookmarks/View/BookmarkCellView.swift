//
//  LinkCellView.swift
//  Linkwarden
//
//  Created by Abilash S on 16/04/24.
//

import SwiftUI

struct BookmarkCellView: View {
    
    @Environment(\.dynamicTypeSize) var sizeCategory
    
    @EnvironmentObject var viewState: BookmarksViewState
    
    @ObservedObject
    var bookmark: Bookmark
    
    var body: some View {
        HStack(spacing: 16) {
            
            Image(uiImage: bookmark.previewImage ?? ImageConstants.bookmarkThumbnail!)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(ThemeManager.secondaryLabel)
                .frame(maxWidth: 64, maxHeight: 64)
                .clipShape(.rect(cornerRadius: 8))
                .onAppear {
                    guard bookmark.previewImage == nil else { return }
                    viewState.imageViewOnAppear(bookmark.bookmarkID)
                }

            VStack(alignment: .leading, spacing: 4) {
                Text(
                    bookmark.name.isEmpty ? bookmark.description.isEmpty ? bookmark.URL
                        .host() ?? "Link not found" : bookmark.description : bookmark.name
                )
                    .font(.headline)
                    .lineLimit(1)
                CellLabelView(labelText: bookmark.URL.host() ?? "Link not found", labelType: .domain)
                if sizeCategory > .xxLarge {
                    VStack(alignment: .leading, spacing: 4) {
                        CellLabelView(labelText: bookmark.collectionID.description, labelType: .collection)
                        CellLabelView(labelText: DateTimeManager.mediumDate.dateFormatter.string(from: bookmark.createdDate), labelType: .date)
                    }
                } else {
                    HStack(spacing: 16) {
                        CellLabelView(labelText: bookmark.collectionID.description, labelType: .collection)
                        CellLabelView(labelText: DateTimeManager.mediumDate.dateFormatter.string(from: bookmark.createdDate), labelType: .date)
                    }
                }
            }
        }
    }
}

#Preview {
    let model = Bookmark.getMockData()
    
    return BookmarkCellView(bookmark: model)
        .background(.gray.opacity(0.20))
}
