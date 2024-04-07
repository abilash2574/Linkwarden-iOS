//
//  LinkwardenApp.swift
//  Linkwarden
//
//  Created by Abilash S on 09/03/24.
//

import SwiftUI
import ToastManager

@main
struct LinkwardenApp: App {
    
    @StateObject private var dataManager = DataManager.shared
    
    var body: some Scene {
        WindowGroup {
            LinkwardenAssembler.getContainerView()
                .environment(\.managedObjectContext, dataManager.container.viewContext)
        }
    }
}

struct ContainerView: View {
    
    @ObservedObject var appState: LinkwardenAppState
    
    var body: some View {
        ZStack {
            if appState.showLoading {
                // TODO: - ZVZV Try to show the replication of UILaunchScreen here, with a progress view that loads until the API is hit.
                ProgressView()
            }
            if appState.showLogin {
                LoginAssembler.getLoginPageView()
            }
            if appState.showHomepage {
                TabBarAssembler.getTabBar()
            }
        }
        .toast(isPresenting: $appState.showToast, duration: 3, animateFromSide: false, backgroundColor: ThemeManager.toastBackground, content: {
            Text(appState.toastMessage)
                .font(.callout)
                .foregroundStyle(.white)
        })
        .environmentObject(appState)
        .onAppear {
            NetworkUtils.startObserving()
            Task {
                /// Check if the session is valid when the container is starts to appear.
                /// A valid session could be identified by hitting the API to get the user ID for the current session token that is stored in the cookie.
                if await appState.isSessionValid {
                    /// On the valid session, we will show the HomePage container view.
                    appState.showHomepage = true
                } else {
                    if !AppState.appLaunchFirstTime {
                        AppState.appLaunchFirstTime = true
                    } else if let _ = Session.getSession() {
                        appState.showToast(with: "Your last login session has expired. Please login again.")
                    }
                    /// Otherwise will show the login page.
                    appState.showLogin = true
                }
                /// Turn off the progress view animation.
                appState.showLoading = false
            }
        }
    }
}
