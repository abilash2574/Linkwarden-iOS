//
//  SettingsView.swift
//  Linkwarden
//
//  Created by Abilash S on 02/04/24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appState: LinkwardenAppState
    
    var body: some View {
        VStack {
            Text("Settings Page")
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
    SettingsView()
}
