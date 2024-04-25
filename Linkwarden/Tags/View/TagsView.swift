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
        Text("Tags Page")
    }
}

#Preview {
    let view = TagsAssembler.getTagsView()
    return view
}
