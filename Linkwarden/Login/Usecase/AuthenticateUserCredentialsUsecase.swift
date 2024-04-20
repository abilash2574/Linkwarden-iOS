//
//  AuthenticateUserCredentialsUsecase.swift
//  Linkwarden
//
//  Created by Abilash S on 13/03/24.
//

import Foundation

class AuthenticateUserCredentialsUsecase: Usecase<AuthenticateUserCredentialsUsecase.Request, AuthenticateUserCredentialsUsecase.Response> {
    
    let dataManager: AuthenticateUserCredentialsDataManagerContract
    
    init(dataManager: AuthenticateUserCredentialsDataManagerContract) {
        self.dataManager = dataManager
    }
    
    override func run(request: Request) async -> UsecaseResult<Response, any Error> {
        switch await dataManager.authenticateUserCredentials(request.type, username: request.username, password: request.password) {
        case .success(let sessionToken):
            return .success(.init(sessionToken: sessionToken))
        case .failure(let error):
            return .failure(error)
        }
    }
    
    class Request: UsecaseRequest {
        
        let type: UsecaseRequestMethod = .remote
        
        let username: String
        let password: String
        
        init(username: String, password: String) {
            self.username = username
            self.password = password
        }
        
    }
    
    class Response: UsecaseResponse {
        let sessionTokenCookie: SessionToken
        
        init(sessionToken: SessionToken) {
            self.sessionTokenCookie = sessionToken
        }
    }
    
}
