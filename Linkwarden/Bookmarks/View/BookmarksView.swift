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
                
                Section {
                    BookmarkCellView(bookmark: bookmark.wrappedValue)
                }
            })
            .listStyle(.insetGrouped)
            .listSectionSpacing(8)
            .background(.gray.opacity(0.2))
            .navigationTitle(viewState.title)
            .navigationBarTitleDisplayMode(viewState.disableLargeTitle ? .inline : .large)
            .toolbar {
                Button {
                    print("ZVZV Save")
                } label: {
                    Label(
                        title: { Text("Add") },
                        icon: { Image(systemName: "plus") }
                    )
                }
            }
        }.onAppear {
            viewState.viewOnAppearing()
        }
        .environmentObject(viewState)
    }
}

// TODO: ZVZV Build preview with mock up data
