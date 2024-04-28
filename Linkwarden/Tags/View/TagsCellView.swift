//
//  TagsCellView.swift
//  Linkwarden
//
//  Created by Abilash S on 27/04/24.
//

import SwiftUI

struct TagsCellView: View {
    
    @Binding var tag: Tag
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            HStack {
                Image(systemName: "tag")
                Text(tag.name)
                    .font(.headline)
                
                Spacer()
                
                CellLabel(labelText: "\(tag.linkCount)", labelType: .number)
            }
            
        }
//        .padding([.leading, .trailing], 8)
        .padding([.top, .bottom], 2)
        
    }
}

#Preview {
   let tag = Tag(tagID: 1, name: "Accounting", ownerID: 234, createdDate: Date(), updatedDate: Date(), linkCount: 8)
    
    return TagsCellView(tag: .constant(tag))
}
