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
                CollectionCellView(collection: collection)
                    .listRowSeparator(.hidden)
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 12)
                            .background(.clear)
                            .foregroundColor(.white)
                            .padding(
                                EdgeInsets(
                                    top: 5,
                                    leading: 16,
                                    bottom: 5,
                                    trailing: 16
                                )
                            )
                    )
            }
            .listStyle(.plain)
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
