//
//  LoginPresenter.swift
//  Linkwarden
//
//  Created by Abilash S on 09/03/24.
//

import Foundation

protocol LoginPresenterContract: AnyObject {
    
    var serverURLCharacterLimit: Int { get }
    var usernameCharacterLimit: Int { get }
    var passwordCharacterLimit: Int { get }
    
    func viewOnAppearing()
    
    func didTapLogin(url: String, username: String, password: String)
    
    @discardableResult
    func validateField(_ type: LoginViewState.Field, value: String) -> Bool
}

class LoginPresenter: LoginPresenterContract {
    
    let getCSRFTokenUsecase: GetCSRFTokenUsecase
    let authenticateUserUsecase: AuthenticateUserCredentialsUsecase
    
    let serverURLCharacterLimit = 255
    let usernameCharacterLimit = 35
    let passwordCharacterLimit = 34
    
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
        viewState?.enableLogin = false
        guard checkAndHandleNetworkConnectivity() else {
            viewState?.hideLoading()
            viewState?.enableLogin = true
            return
        }
        
        var isValid = true
        
        for field in LoginViewState.Field.allCases {
            if !validateField(field, value: viewState?.getValue(for: field) ?? "") {
                isValid = false
            }
        }
        
        guard isValid else {
            viewState?.hideLoading()
            viewState?.enableLogin = true
            return
        }
        
        Task(priority: .userInitiated) { [weak self] in
            guard let self else {
                LLogger.shared.critical("Self found to be nil")
                self?.viewState?.hideLoading()
                self?.viewState?.enableLogin = true
                return
            }
            
            guard await resetAndCreateSession(url: url) else {
                viewState?.showToast(with: "Uh-oh! Something went wrong. Please contact the developer by sending feedback from the app.")
                return
            }
            
            if await checkAndLoginUser(username: username, password: password) {
                await MainActor.run {
                    LinkwardenAppState.shared.didLoginSuccessfully()
                }
            } else {
                await resetSession()
            }
            
            await MainActor.run {
                self.viewState?.hideLoading()
                self.viewState?.enableLogin = true
            }
        }
    }
    
    @discardableResult
    func validateField(_ type: LoginViewState.Field, value: String) -> Bool {
        var warning: LocalizedStringResource = ""
        var showWarning: Bool = true
        switch type {
        case .serverURL:
            if value.isEmpty {
                warning = "Server URL can't be empty"
            } else if !(Validator.isValidDomainURL(value) || Validator.isValidIPv4Address(value) || Validator.isValidIPv6Address(value)) {
                warning = "Please enter a valid domain/IP Address"
            } else {
                showWarning = false
            }
        case .username:
            if value.isEmpty {
                warning = "Username can't be empty"
            } else {
                showWarning = false
            }
        case .password:
            if value.isEmpty {
                warning = "Password can't be empty"
            } else {
                showWarning = false
            }
        }
        if showWarning {
            viewState?.showWarningForField(type, warning: warning)
            return false
        } else {
            viewState?.hideWarningForField(type)
            return true
        }
    }
    
}

extension LoginPresenter {
    
    private func loadInitialSetup() {
        guard checkAndHandleNetworkConnectivity() else {
            return
        }
        Task { [weak self] in 
            await self?.resetSession()
        }
    }
    
    @discardableResult
    private func resetSession() async -> Bool {
        DispatchQueue.global(qos: .background).async {
            HTTPCookieStorage.shared.removeCookies(since: .distantPast)
        }
        return await Session.deleteSession()
    }
    
    private func resetAndCreateSession(url: String) async -> Bool {
        guard await resetSession() else {
            LLogger.shared.critical("Couldn't reset session")
            return false
        }
        
        let session = Session(context: DataManager.shared.context)
        session.baseURL = url
        
        return saveCoreDateChanges()
    }
    
    @discardableResult
    private func saveCoreDateChanges() -> Bool {
        do {
            try DataManager.shared.context.save()
            return true
        } catch {
            LLogger.shared.critical("Message: Couldn't save the login credentials\nError:\(error)")
            return false
        }
    }
    
    private func checkAndLoginUser(username: String, password: String) async -> Bool {
        guard await getCSRFToken() else {
            viewState?.showToast(with: "Oops! Something unexpected occurred. Please check the server URL and try again.", replace: false)
            return false
        }
        
        guard await authenticateUser(username, with: password) else {
            viewState?.showToast(with: "Login failed. Please check your credentials and try again.")
            return false
        }
        
        guard await LinkwardenAppState.shared.isSessionValid else {
            LLogger.shared.critical("Session Not valid even after getting session token successfully.")
            viewState?.showToast(with: "Login failed. Please check your credentials and try login again.")
            return false
        }
        
        return true
    }
    
}

extension LoginPresenter {

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
    
    private func getCSRFToken() async -> Bool {
        let request = GetCSRFTokenUsecase.Request()
        switch await self.getCSRFTokenUsecase.execute(request: request) {
        case .success(let response):
            guard let key = response.token.cookieKey, let value = response.token.cookieValue else {
                // TODO: ZVZV Show a feedback alert and send feedback.
                viewState?.showToast(with: "Uh-oh! Something went wrong. Please contact the developer by sending feedback from the app.")
                LLogger.shared.critical("CSRF Token found to be nil after successful CSRF token API.")
                return false
            }
            guard let session = Session.getSession() else {
                viewState?.showToast(with: "Uh-oh! Something went wrong. Please contact the developer by sending feedback from the app.")
                LLogger.shared.critical("Session from core data found to be nil.")
                return false
            }
            session.csrfToken = response.token.csrfToken
            session.csrfCookie = "\(key)=\(value)"
            return saveCoreDateChanges()
        case .failure(let error):
            LLogger.shared.critical("CSRF Token failed \(error)")
            return false
        }
    }
    
    private func authenticateUser(_ username: String, with password: String) async -> Bool {
        let request = AuthenticateUserCredentialsUsecase.Request(username: username, password: password)
        switch await self.authenticateUserUsecase.execute(request: request) {
        case .success(let token):
            guard let session = Session.getSession() else {
                viewState?.showToast(with: "Uh-oh! Something went wrong. Please contact the developer by sending feedback from the app.")
                LLogger.shared.critical("Session is found to be nil after authenticating the user credentials.")
                return false
            }
            session.sessionCookie = "\(token.sessionTokenCookie.cookieKey)=\(token.sessionTokenCookie.cookieToken)"
            session.sessionExpiry = token.sessionTokenCookie.expiryDate
            LLogger.shared.info("User logged in successfully")
            return saveCoreDateChanges()
        case .failure(let error):
            LLogger.shared.critical("Not authenticated user \(error)")
            return false
        }
    }
    
}
