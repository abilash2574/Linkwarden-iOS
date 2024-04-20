//
//  BookmarksView.swift
//  Linkwarden
//
//  Created by Abilash S on 02/04/24.
//

import SwiftUI

struct BookmarksView: View {
    
    @ObservedObject var viewState: BookmarksViewState
    
    var body: some View {
        NavigationStack {
            List($viewState.bookmarks, id: \.bookmarkID, rowContent: { bookmark in
                BookmarkCellView(bookmark: bookmark.wrappedValue)
                    .listRowSeparator(.hidden)
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 5)
                            .background(.clear)
                            .foregroundColor(.white)
                            .padding(
                                EdgeInsets(
                                    top: 2,
                                    leading: 10,
                                    bottom: 2,
                                    trailing: 10
                                )
                            )
                    )
            })
            .listStyle(.plain)
            .background(.gray.opacity(0.2))
            .navigationTitle("Bookmarks")
        }.onAppear {
            viewState.viewOnAppearing()
        }
    }
}

// TODO: ZVZV Build preview with mock up data
