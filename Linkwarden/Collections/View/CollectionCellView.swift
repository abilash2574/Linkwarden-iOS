//
//  CollectionCellView.swift
//  Linkwarden
//
//  Created by Abilash S on 27/04/24.
//

import SwiftUI

struct CollectionCellView: View {
    
    @Binding var collection: Collection
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .foregroundStyle(.gray.opacity(0.2))
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: 28, maxHeight: 28)
                    .clipShape(.rect(cornerRadius: 14, style: .circular))
                
                Text(collection.name)
                    .font(.headline)
            }
            
            HStack(spacing: 16) {
                CellLabelView(labelText: DateTimeManager.mediumDate.dateFormatter.string(from: collection.createdDate), labelType: .date)
                
                CellLabelView(labelText: "\(collection.count)", labelType: .domain)
                
                Spacer()
            }
        }
        .padding(8)
        
    }
}

#Preview {
    let collection = Collection(collectionID: 1, name: "Social", description: "Nothing", color: "#ffffff", isPublic: true, ownerID: 2, createdDate: Date(), updatedDate: Date(), count: 4)
    
    return CollectionCellView(collection: .constant(collection))
}
