//
//  LoginPresenter.swift
//  Linkwarden
//
//  Created by Abilash S on 09/03/24.
//

import Foundation

protocol LoginPresenterContract: AnyObject {
    
    func viewOnAppearing()
    
    func didTapLogin(url: String, username: String, password: String)
}

class LoginPresenter: LoginPresenterContract {
    
    let getCSRFTokenUsecase: GetCSRFTokenUsecase
    let authenticateUserUsecase: AuthenticateUserCredentialsUsecase
    
    public weak var viewState: LoginViewStateContract?
    
    init(getCSRFTokenUsecase: GetCSRFTokenUsecase, authenticateUserUsecase: AuthenticateUserCredentialsUsecase) {
        self.getCSRFTokenUsecase = getCSRFTokenUsecase
        self.authenticateUserUsecase = authenticateUserUsecase
    }
    
    func viewOnAppearing() {
        loadInitialSetup()
    }
    
    func didTapLogin(url: String, username: String, password: String) {
        
        viewState?.showLoading()
        
        Task(priority: .userInitiated) { [weak self] in
            guard let self else {
                // TODO: ZVZV Handle guard
                return
            }
            NetworkManager.setBaseURL(url)
            
            if await getCSRFToken() {
                if await authenticateUser(username, with: password) {
                    print("Logged in")
                } else {
                    print("Something went wrong")
                }
            } else {
                print("Something Went wrong")
            }
            await MainActor.run(body: {
                self.viewState?.hideLoading()
            })
        }
        
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
    
    private func authenticateUser(_ username: String, with password: String) async -> Bool {
        let request = AuthenticateUserCredentialsUsecase.Request(username: username, password: password)
        switch await self.authenticateUserUsecase.execute(request: request) {
        case .success(let token):
            let cookie = [token.sessionTokenCookie.cookieKey:token.sessionTokenCookie.cookieToken, "ExpiryDate":token.sessionTokenCookie.expiryDate] as [String : Any]
            NetworkManager.sessionTokenCookie = cookie
            
            print("Successful Login")
            
            return true
            
        case .failure(let error):
            // TODO: ZVZV Handle this error
            LLogger.shared.critical("Not authenticated user \(error)")
            print("Incorrect Message")
            
            return false
        }
    }
    
}
