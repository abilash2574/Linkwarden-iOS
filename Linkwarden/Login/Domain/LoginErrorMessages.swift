//
//  LoginErrorMessages.swift
//  Linkwarden
//
//  Created by Abilash S on 03/04/24.
//

import Foundation

enum LoginErrorMessages {
    
    case NoInternetConnection
    
    var toastMessage: String {
        switch self {
        case .NoInternetConnection:
            return "Seems like you are offline. Please check your internet connection and try again later."
        }
    }
    
    var logMessage: String {
        switch self {
        case .NoInternetConnection:
            return "Device is offline. No Internet connection."
        }
    }
    
}
