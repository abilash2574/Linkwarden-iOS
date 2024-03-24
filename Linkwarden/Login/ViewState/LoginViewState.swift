//
//  LoginViewState.swift
//  Linkwarden
//
//  Created by Abilash S on 09/03/24.
//

import Foundation
import SwiftUI

protocol LoginViewStateContract: AnyObject {
    
    var enableLogin: Bool { get set }
    
    func showLoading()
    func hideLoading()
    
    
}

class LoginViewState: LoginViewStateContract, ObservableObject {
    
    struct LoginTextFieldConfig: Identifiable {
        var id: UUID
        var image: Image
        var placeholder: String
        var keyboardType: UIKeyboardType
        var contentType: UITextContentType
        var isSecure: Bool
        var focusedField: Field
    }

    enum Field {
        case serverURL
        case userName
        case password
    }
    
    var presenter: LoginPresenterContract
    
    @Published var serverURL = ""
    @Published var userName = ""
    @Published var password = ""
    
    @Published var enableScrollView = false
    @Published var enableLogin = true
    
    @Published var showLoadingView: Bool = false
    
    var textFieldConfig: [LoginTextFieldConfig] = [
        LoginTextFieldConfig(id: UUID(), image: Image(systemName: "cloud.fill"), placeholder: "Server URL", keyboardType: .URL, contentType: .URL, isSecure: false, focusedField: .serverURL),
        LoginTextFieldConfig(id: UUID(), image: Image(systemName: "person.fill"), placeholder: "Username", keyboardType: .default, contentType: .username, isSecure: false, focusedField: .userName),
        LoginTextFieldConfig(id: UUID(), image: Image(systemName: "lock.fill"), placeholder: "Password", keyboardType: .default, contentType: .password, isSecure: true, focusedField: .password)
    ]
    
    init(presenter: LoginPresenterContract) {
        self.presenter = presenter
    }
    
}

extension LoginViewState {
    
    func viewOnAppearing() {
        presenter.viewOnAppearing()
    }
    
    func didTapLogin() {
        presenter.didTapLogin(url: serverURL, username: userName, password: password)
    }
    
}

extension LoginViewState {
    
    func showLoading() {
        showLoadingView = true
    }
    
    func hideLoading() {
        showLoadingView = false
    }
    
}
