//
//  BookmarksAddFormView.swift
//  Linkwarden
//
//  Created by Abilash S on 22/06/24.
//

import SwiftUI

struct BookmarksAddFormView: View {
    
    @ObservedObject var viewState: BookmarksAddFormState
    
    @State var url: String = ""
    @State var title: String = ""
    @State var description: String = ""
    @State var tags: String = ""
    @State var collection: String = ""

    var body: some View {
        
        Form {
            Section {
                
                TextField(BookmarksAddFormFields.url.displayName.key, text: $url)
                
            }
            
            Section {
                
                TextField(BookmarksAddFormFields.title.displayName.key, text: $title)
                TextField(BookmarksAddFormFields.description.displayName.key, text: $description)

            }
            
            Section {
                Text(BookmarksAddFormFields.tags.displayName.key)
                Text(BookmarksAddFormFields.collection.displayName.key)
            }
            
        }
        
    }
}

#Preview {
    BookmarksAssembler.getBookmarksAddFormView()
}
