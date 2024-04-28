//
//  SettingsAssembler.swift
//  Linkwarden
//
//  Created by Abilash S on 28/04/24.
//

import Foundation

class SettingsAssembler {
    
    static func getSettingsView() -> SettingsView {
        let presenter = SettingsPresenter()
        let viewState = SettingsViewState(presenter: presenter)
        presenter.viewState = viewState
        
        let settingsView = SettingsView(viewState: viewState)
        return settingsView
    }
    
    static func getSettingsViewWithMockData() -> SettingsView {
        let presenter = SettingsPresenter()
        let viewState = SettingsViewState(presenter: presenter)
        presenter.viewState = viewState
        viewState.user = User.mockUser
        return SettingsView(viewState: viewState)
    }
    
}
