//
//  SingleSelectionCell.swift
//  Linkwarden
//
//  Created by Abilash S on 06/05/24.
//

import SwiftUI

struct SingleSelectionCell: View {
    
    var isSelected: Bool = false
    var text: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(text)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark.circle")
                } else {
                    Image(systemName: "circle")
                }
            }
        }
    }
}

#Preview {
    SingleSelectionCell(isSelected: true, text: "Demo", action: { })
}
