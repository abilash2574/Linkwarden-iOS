//
//  TagsView.swift
//  Linkwarden
//
//  Created by Abilash S on 02/04/24.
//

import SwiftUI

struct TagsView: View {
    
    @ObservedObject var viewState: TagsViewState
    
    var body: some View {
        
        NavigationStack {
            List($viewState.tags, id: \.tagID ) { tag in
                
                TagsCellView(tag: tag)
                
            }
            .listStyle(.plain)
            .background(.gray.opacity(0.2))
            .navigationTitle("Tags")
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
    let view = TagsAssembler.getTagsView()
    return view
}
