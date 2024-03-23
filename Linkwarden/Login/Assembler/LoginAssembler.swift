//
//  LoginAssembler.swift
//  Linkwarden
//
//  Created by Abilash S on 09/03/24.
//

import Foundation

class LoginAssembler {
    
    class func getLoginPageView() -> LoginPageView {
        
        let getCSRFToken = getCSRFTokenUsecase()
        let authenticateUserUsecase =  getAuthenticateUserUsecase()
        
        let presenter = LoginPresenter(getCSRFTokenUsecase: getCSRFToken, authenticateUserUsecase: authenticateUserUsecase)
        
        let viewState = LoginViewState(presenter: presenter)
        presenter.viewState = viewState
        
        let loginView = LoginPageView(viewState: viewState)
        return loginView
    }
    
    class func getCSRFTokenUsecase() -> GetCSRFTokenUsecase {
        let networkService = GetCSRFTokenNetworkService()
        let dataManager = GetCSRFTokenDataManager(networkService: networkService)
        return GetCSRFTokenUsecase(dataManager: dataManager)
    }
    
    class func getAuthenticateUserUsecase() -> AuthenticateUserCredentialsUsecase {
        let networkService = AuthenticateUserCredentialsNetworkService()
        let dataManager = AuthenticateUserCredentialsDataManager(networkService: networkService)
        return AuthenticateUserCredentialsUsecase(dataManager: dataManager)
    }
     
}
