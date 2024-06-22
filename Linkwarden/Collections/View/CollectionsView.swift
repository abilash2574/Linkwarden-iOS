//
//  CollectionsView.swift
//  Linkwarden
//
//  Created by Abilash S on 02/04/24.
//

import SwiftUI

struct CollectionsView: View {
    
    @ObservedObject var viewState: CollectionsViewState
    
    var body: some View {
        
        NavigationStack {
            List($viewState.collections, id: \.collectionID) { collection in
                Section {
                    NavigationLink(destination: {
                        let bookmarkView = BookmarksAssembler.getBookmarksView(collectionID: collection.collectionID.wrappedValue)
                        bookmarkView.viewState.disableLargeTitle = true
                        bookmarkView.viewState.title = collection.name.wrappedValue
                        return bookmarkView
                    }()) {
                        CollectionCellView(collection: collection)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .listSectionSpacing(8)
            .background(.gray.opacity(0.2))
            .navigationTitle("Collections")
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

#Preview {
    let view = CollectionsAssembler.getCollectionsView()
    return view
}
