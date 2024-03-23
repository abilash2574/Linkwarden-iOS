//
//  AuthenticateUserCredentialsDataManager.swift
//  Linkwarden
//
//  Created by Abilash S on 13/03/24.
//

import Foundation

protocol AuthenticateUserCredentialsDataManagerContract {
    
    func authenticateUserCredentials(_ type: UsecaseRequestMethod, username: String, password: String) async -> UsecaseResult<SessionToken, Error>
    
}

class AuthenticateUserCredentialsDataManager: AuthenticateUserCredentialsDataManagerContract {

    let networkService: AuthenticateUserCredentialsNetworkServiceContract
    
    init(networkService: AuthenticateUserCredentialsNetworkServiceContract) {
        self.networkService = networkService
    }
    
    func authenticateUserCredentials(_ type: UsecaseRequestMethod, username: String, password: String) async -> UsecaseResult<SessionToken, Error>  {
        switch type {
        case .local:
            return .failure(LError.NoLocalDataManager)
        case .remote:
            return await networkService.authenticateUser(username: username, password: password)
        }
    }
    
    
}
