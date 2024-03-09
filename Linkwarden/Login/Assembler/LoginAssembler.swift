//
//  LoginAssembler.swift
//  Linkwarden
//
//  Created by Abilash S on 09/03/24.
//

import Foundation

class LoginAssembler {
    
    class func getLoginPageView() -> LoginPageView {
        let presenter = LoginPresenter()
        let viewState = LoginViewState(presenter: presenter)
        let loginView = LoginPageView(viewState: viewState)
        return loginView
    }
    
}
