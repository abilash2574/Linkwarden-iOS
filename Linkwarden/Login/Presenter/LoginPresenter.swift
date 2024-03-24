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
                LLogger.shared.critical("Self found to be nil")
                return
            }
            NetworkManager.setBaseURL(url)
            
            if await getCSRFToken() {
                if await authenticateUser(username, with: password) {
                    if await LinkwardenAppState.shared.isSessionValid {
                        await MainActor.run {
                            LinkwardenAppState.shared.showLogin = false
                            LinkwardenAppState.shared.showHomepage = true
                        }
                    }
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
            // Toast manager
            // Disable the login & create account button
            viewState?.enableLogin = false
        }
        
        HTTPCookieStorage.shared.removeCookies(since: .distantPast)
        NetworkManager.csrfToken = nil
        NetworkManager.csrfTokenCookie = nil
        NetworkManager.sessionTokenCookie = nil
    }
    
    private func getCSRFToken() async -> Bool {
        let request = GetCSRFTokenUsecase.Request()
        switch await self.getCSRFTokenUsecase.execute(request: request) {
        case .success(let response):
            guard let key = response.token.cookieKey, let value = response.token.cookieValue else {
                // TODO: ZVZV Handle With a toast
                // Toast Message Something went wrong. Please send feedback
                return false
            }
            NetworkManager.csrfToken = response.token.csrfToken
            NetworkManager.csrfTokenCookie = "\(key)=\(value)"
            return true
        case .failure(let error):
            // TODO: ZVZV Handle with a Toast
            // Toast Message,
            LLogger.shared.critical("CSRF Token failed \(error)")
            return false
        }
    }
    
    private func authenticateUser(_ username: String, with password: String) async -> Bool {
        let request = AuthenticateUserCredentialsUsecase.Request(username: username, password: password)
        switch await self.authenticateUserUsecase.execute(request: request) {
        case .success(let token):
            let cookie = ["SessionToken":"\(token.sessionTokenCookie.cookieKey)=\(token.sessionTokenCookie.cookieToken)", "ExpiryDate":token.sessionTokenCookie.expiryDate] as [String : Any]
            NetworkManager.sessionTokenCookie = cookie
            print("Successful Login")
            return true
        case .failure(let error):
            // TODO: ZVZV Handle with a toast message.
            LLogger.shared.critical("Not authenticated user \(error)")            
            return false
        }
    }
    
}
