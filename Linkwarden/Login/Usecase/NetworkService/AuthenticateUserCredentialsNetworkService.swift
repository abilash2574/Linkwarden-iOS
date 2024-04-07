//
//  AuthenticateUserCredentialsNetworkService.swift
//  Linkwarden
//
//  Created by Abilash S on 13/03/24.
//

import Foundation
import APIManager

protocol AuthenticateUserCredentialsNetworkServiceContract: NetworkServiceContract {
    
    func authenticateUser(username: String, password: String) async -> UsecaseResult<SessionToken, Error>
    
}

class AuthenticateUserCredentialsNetworkService: AuthenticateUserCredentialsNetworkServiceContract {
    
    var urlString: String { "\(NetworkManager.getBaseURL())\(NetworkManager.APIPath)/auth/callback/credentials" }
    
    lazy var headers = ["Content-Type" : "application/json; charset=utf-8"]
    
    func authenticateUser(username: String, password: String) async -> UsecaseResult<SessionToken, Error> {
        guard isOnline() else {
            return .failure(No_Network_API_Error)
        }
        
        guard let url = URL(string: urlString) else {
            return .failure(APINetworkError.apiManagerError(status: APIErrorStatus.invalidURLString, message: LErrorMessage.Invalid_URL_String, info: nil))
        }
        
        let requestBody: [String: Any] = ["username": username, "password": password, "csrfToken": NetworkManager.csrfToken ?? "",  "json": true]

        headers["Cookie"] = "\(NetworkManager.csrfTokenCookie!);"
        
        switch await APIManager.makeRequest(.POST, withURL: url, headers: headers, requestBody: requestBody) {
        case .success(_, let response):
            if response.statusCode == 200 {
                
                let cookieStorage = HTTPCookieStorage.shared
                let cookies = cookieStorage.cookies(for: url) ?? []
                var sessionCookie: SessionToken?
                
                for cookie in cookies {
                    if cookie.name == "__Secure-next-auth.session-token" {
                        guard let expiryDate = cookie.expiresDate else {
                            return .failure(APINetworkError.processingError(status: APIErrorStatus.internalError, message: "Cookie expiration date not found", info: nil))
                        }
                        sessionCookie = SessionToken(cookieKey: cookie.name, cookieToken: cookie.value, expiryDate: expiryDate)
                    }
                }
                
                guard let sessionCookie else {
                    return .failure(APINetworkError.processingError(status: APIErrorStatus.internalError, message: "Cookie Not found", info: nil))
                }
                
                return .success(sessionCookie)
                                
            } else {
                return .failure(APINetworkError.apiManagerError(status: APIErrorStatus.invalidResponseCode, message: LErrorMessage.Invalid_Response_Code, info: nil))
            }
            
        case .failure(let error):
            return .failure(error)
        }
        
    }
    
    
}
