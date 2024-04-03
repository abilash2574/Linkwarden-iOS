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
    
    func showWarningForField(_ field: LoginViewState.Field, warning: String)
    func hideWarningForField(_ field: LoginViewState.Field)
    
    func getValue(for field: LoginViewState.Field) -> String
    
}

class LoginViewState: LoginViewStateContract, ObservableObject {
    
    struct LoginTextFieldConfig: Identifiable {
        var id: UUID
        var image: Image
        var placeholder: String
        var keyboardType: UIKeyboardType
        var contentType: UITextContentType
        var characterLimit: Int
        var isSecure: Bool
        var focusedField: Field
        var validation: (String) -> ()
    }

    enum Field: CaseIterable {
        case serverURL
        case username
        case password
    }
    
    var presenter: LoginPresenterContract
    
    @Published var serverURL = ""
    @Published var username = ""
    @Published var password = ""
    
    @Published var serverError = ""
    @Published var usernameError = ""
    @Published var passwordError = ""
    
    @Published var enableLogin = true
    
    @Published var showLoadingView: Bool = false
    
    @Published var showCreateAccount: Bool = false
    
    lazy var textFieldConfig: [LoginTextFieldConfig] = [
        LoginTextFieldConfig(id: UUID(), image: ImageConstants.serverFieldIcon, placeholder: "Server URL", keyboardType: .URL, contentType: .URL, characterLimit: presenter.serverURLCharacterLimit, isSecure: false, focusedField: .serverURL, validation: { [weak self] in self?.presenter.validateField(.serverURL, value: $0) }),
        LoginTextFieldConfig(id: UUID(), image: ImageConstants.userFieldIcon, placeholder: "Username", keyboardType: .default, contentType: .username, characterLimit: presenter.usernameCharacterLimit, isSecure: false, focusedField: .username, validation: { [weak self] in self?.presenter.validateField(.username, value: $0) }),
        LoginTextFieldConfig(id: UUID(), image: ImageConstants.passwordFieldIcon, placeholder: "Password", keyboardType: .default, contentType: .password, characterLimit: presenter.passwordCharacterLimit, isSecure: true, focusedField: .password, validation: { [weak self] in self?.presenter.validateField(.password, value: $0) })
    ]
    
    init(presenter: LoginPresenterContract) {
        self.presenter = presenter
    }
    
    func getValue(for field: Field) -> String {
        switch field {
        case .serverURL:
            serverURL
        case .username:
            username
        case .password:
            password
        }
    }
    
}

extension LoginViewState {
    
    func viewOnAppearing() {
        presenter.viewOnAppearing()
    }
    
    func didTapLogin() {
        presenter.didTapLogin(url: serverURL, username: username, password: password)
    }
    
    func validate(_ field: Field) {
        switch field {
        case .serverURL:
            presenter.validateField(field, value: serverURL)
        case .username:
            presenter.validateField(field, value: username)
        case .password:
            presenter.validateField(field, value: password)
        }
    }
    
}

extension LoginViewState {
    
    func showLoading() {
        showLoadingView = true
    }
    
    func hideLoading() {
        showLoadingView = false
    }
    
    func showWarningForField(_ field: Field, warning: String) {
        switch field {
        case .serverURL:
            serverError = warning
        case .username:
            usernameError = warning
        case .password:
            passwordError = warning
        }
    }
    
    func hideWarningForField(_ field: LoginViewState.Field) {
        switch field {
        case .serverURL:
            serverError = ""
        case .username:
            usernameError = ""
        case .password:
            passwordError = ""
        }
    }
    
}
