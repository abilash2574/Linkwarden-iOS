//
//  SettingsPresenter.swift
//  Linkwarden
//
//  Created by Abilash S on 28/04/24.
//

import Foundation

protocol SettingsPresenterContract {
    
    func viewOnAppearing()
    
}

class SettingsPresenter: SettingsPresenterContract {
    
    weak var viewState: SettingsViewStateContract?
    
    var viewDidLoadTheFirstTime: Bool = false
    
    init() { }
    
    func viewOnAppearing() {
        guard checkAndHandleNetworkConnectivity(), !viewDidLoadTheFirstTime else {
            return
        }

        viewState?.user = getUser()
        viewDidLoadTheFirstTime = true
    }
    
}

extension SettingsPresenter {
    
    /// This will check if the internet connection is available and if not will show the offline view.
    /// - Returns: Returns a Bool according to the result.
    private func checkAndHandleNetworkConnectivity() -> Bool {
        guard NetworkUtils.isNetworkAccessible else {
            viewState?.isOnline = false
            LLogger.shared.critical("Device is offline. No Internet connection.")
            return false
        }
        viewState?.isOnline = true
        return true
    }
    
    private func getUser() -> User? {
        guard let user = AppState.user else {
            // TODO: ZVZV Handle this state.
            return nil
        }
        
        return user
    }
    
}

