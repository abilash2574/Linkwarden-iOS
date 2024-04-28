//
//  SettingsView.swift
//  Linkwarden
//
//  Created by Abilash S on 02/04/24.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var appState: LinkwardenAppState
    
    @ObservedObject var viewState: SettingsViewState
    
    var body: some View {
        
        NavigationStack {
            
            VStack(alignment: .leading) {
                
                ProfileView(user: $viewState.user)
                    .padding([.top, .bottom], 16)
                    .padding([.leading, .trailing], 16)
                
            }
            .navigationTitle("Profile")
            .background(.gray.opacity(0.2))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(role: .destructive) {
                        appState.showHomepage = false
                        appState.showLogin = true
                    } label: {
                        Label(
                            title: { Text("Logout") },
                            icon: {
                                ImageConstants.logoutIcon
                                    .renderingMode(.original)
                            }
                        )
                    }
                }
            }
            .background(.white)
            
        }
        .onAppear {
            viewState.viewOnAppearing()
        }
        .environmentObject(viewState)
        
    }
    
}

#Preview {
    return SettingsAssembler.getSettingsViewWithMockData()
}
