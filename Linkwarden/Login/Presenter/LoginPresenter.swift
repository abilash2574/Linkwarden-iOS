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
//        NetworkManager.setBaseURL("https://link.zeyrie.org")
//        getCSRFToken()
    }
    
    private func getCSRFToken() {
        Task(priority: .background, operation: {
            let request = GetCSRFTokenUsecase.Request()
            switch await self.getCSRFTokenUsecase.execute(request: request) {
            case .success(let response):
                NetworkManager.csrfToken = response.token.csrfToken
                self.didSetCSRFToken()
            case .failure(let error):
                // TODO: ZVZV Handle this error
                LLogger.shared.critical("CSRF Token failed \(error)")
            }
        })
    }
    
    private func didSetCSRFToken() {
        
    }
    
}
