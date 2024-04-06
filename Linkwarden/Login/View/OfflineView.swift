//
//  OfflineView.swift
//  Linkwarden
//
//  Created by Abilash S on 03/04/24.
//

import SwiftUI

struct OfflineView: View {
    
    var buttonAction: () -> ()
    
    var body: some View {
        VStack(spacing: 60) {
            VStack {
                Image(systemName: "wifi.slash")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 100, maxHeight: 100)
                    .foregroundStyle(.regularMaterial)
                    .padding(.bottom)
                Text("Seems you are offline")
                    .font(.title2)
                    .foregroundStyle(.white)
            }
            
            Button {
                buttonAction()
            } label: {
                Text("Retry")
                    .font(.title3)
                    .fontWeight(.bold)
                    .frame(minWidth: 130, maxWidth: 200)
                    .foregroundStyle(.themeABackground)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.regular)
        }
    }
}

#Preview {
    OfflineView(buttonAction: {})
}
