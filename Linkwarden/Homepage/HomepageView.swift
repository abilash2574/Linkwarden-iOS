//
//  HomepageView.swift
//  Linkwarden
//
//  Created by Abilash S on 24/03/24.
//

import SwiftUI

struct HomepageView: View {
    
    @EnvironmentObject var appState: LinkwardenAppState
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Button{
                appState.showHomepage = false
                appState.showLogin = true
            } label: {
                Text("Logout")
            }
        }
    }
}

#Preview {
    HomepageView()
}
