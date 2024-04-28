//
//  CellLabelView.swift
//  Linkwarden
//
//  Created by Abilash S on 27/04/24.
//

import SwiftUI

struct CellLabelView: View {
    
    enum CellLabelViewType {
        case domain
        case collection
        case date
        case number
    }
    
    var labelText: String
    
    var labelType: CellLabelViewType
    
    var imageValue: Image {
        switch labelType {
        case .domain:
            ImageConstants.domainIcon
        case .collection:
            ImageConstants.folderIcon
        case .date:
            ImageConstants.calendarIcon
        case .number:
            ImageConstants.numberIcon
        }
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            if labelType == .domain {
                imageValue
                    .renderingMode(.template)
                    .resizable()
                    .imageScale(.small)
                    .foregroundStyle(ThemeManager.secondaryLabel)
                    .frame(maxWidth: 18, maxHeight: 10)
            } else {
                imageValue
                    .renderingMode(.template)
                    .imageScale(.small)
                    .foregroundStyle(ThemeManager.secondaryLabel)
            }
            Text(labelText)
                .truncationMode(.tail)
                .lineLimit(1)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(ThemeManager.secondaryLabel)
        }
    }
}

#Preview {
    CellLabelView(labelText: "23-12-2024", labelType: .date)
}
