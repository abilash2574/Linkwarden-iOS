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
                
                Form {
                    Section("Format") {
                        ForEach(SettingsArchiveFormats.allCases, id: \.self) { format in
                            MultiSelectionCell(isSelected: viewState.selectedFormats.contains(format), text: format.rawValue) { isSelected in
                                if isSelected {
                                    viewState.selectedFormats.insert(format)
                                } else {
                                    viewState.selectedFormats.remove(format)
                                }
                            }
                        }
                    }
                    Section {
                        HStack {
                            Text("Allow Duplicate Links")
                                .lineLimit(2)
                            Toggle("", isOn: $viewState.allowDuplicateLink)
                        }
                    }
                    Section("Default Link Action") {
                        ForEach(SettingsDefaultLinkAction.allCases, id: \.self) { action in
                            SingleSelectionCell(isSelected: viewState.selectedLinkAction == action, text: action.rawValue) {
                                guard viewState.selectedLinkAction != action else { return }
                                viewState.selectedLinkAction = action
                            }
                        }
                    }
                }
                .formStyle(.grouped)
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
                        Image(systemName: "power")
                            .renderingMode(.template)
                            .foregroundStyle(.red)
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
