//
//  LinkwardenApp.swift
//  Linkwarden
//
//  Created by Abilash S on 09/03/24.
//

import SwiftUI

@main
struct LinkwardenApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContainerView()
        }
    }
}

struct ContainerView: View {
    
    @ObservedObject var appState = LinkwardenAppState.shared
    
    var body: some View {
        ZStack {
            if appState.showLoading {
                ProgressView()
            }
            if appState.showLogin {
                LoginAssembler.getLoginPageView()
            }
            if appState.showHomepage {
                HomepageView()
            }
        }
        .onAppear(perform: {
            Task {
                if await appState.isSessionValid {
                    appState.showHomepage = true
                } else {
                    appState.showLogin = true
                }
                appState.showLoading = false
            }
        })
    }
}
