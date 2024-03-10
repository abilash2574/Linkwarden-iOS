//
//  LoginPresenter.swift
//  Linkwarden
//
//  Created by Abilash S on 09/03/24.
//

import Foundation

protocol LoginPresenterContract: AnyObject {
    
    func viewOnAppearing()
}

class LoginPresenter: LoginPresenterContract {
    
    let getCSRFTokenUsecase: GetCSRFTokenUsecase
    
    public weak var viewState: LoginViewStateContract?
    
    init(getCSRFTokenUsecase: GetCSRFTokenUsecase) {
        self.getCSRFTokenUsecase = getCSRFTokenUsecase
    }
    
    func viewOnAppearing() {
        loadInitialSetup()
    }
    
}

extension LoginPresenter {
    
    private func loadInitialSetup() {
        // Reset the base URL for the app
        NetworkManager.setBaseURL(String())
        if !NetworkUtils.isNetworkAccessible {
            // TODO: ZVZV Show No Internet connection View
            
        }
    }
    
    private func getCSRFToken() {
        
    }
    
}
