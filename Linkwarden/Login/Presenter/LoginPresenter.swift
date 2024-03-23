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
        if !NetworkUtils.isNetworkAccessible {
            // TODO: ZVZV Show No Internet connection View
            
        }
    }
    
    private func getCSRFToken() async -> Bool {
        let request = GetCSRFTokenUsecase.Request()
        switch await self.getCSRFTokenUsecase.execute(request: request) {
        case .success(let response):
            guard let key = response.token.cookieKey, let value = response.token.cookieValue else {
                // TODO: ZVZV Handle a terminal error
                return false
            }
            NetworkManager.csrfToken = response.token.csrfToken
            NetworkManager.csrfTokenCookie = "\(key)=\(value)"
            return true
        case .failure(let error):
            // TODO: ZVZV Handle this error
            LLogger.shared.critical("CSRF Token failed \(error)")
            return false
        }
    }
    
    private func didSetCSRFToken() {
        
    }
    
}
