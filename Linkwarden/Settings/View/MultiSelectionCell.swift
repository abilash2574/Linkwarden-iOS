//
//  SingleSelectionCell.swift
//  Linkwarden
//
//  Created by Abilash S on 06/05/24.
//

import SwiftUI

struct MultiSelectionCell: View {
    
    @State var isSelected: Bool = false
    var text: String
    var didTapCell: (Bool) -> Void
    
    var body: some View {
        Button {
            isSelected.toggle()
            didTapCell(isSelected)
        } label: {
            HStack {
                Text(text)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

#Preview {
    MultiSelectionCell(isSelected: true, text: "Demo") { isSelected in
        
    }
}
