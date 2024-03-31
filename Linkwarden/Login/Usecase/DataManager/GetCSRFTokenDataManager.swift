//
//  GetCSRFTokenDataManager.swift
//  Linkwarden
//
//  Created by Abilash S on 10/03/24.
//

import Foundation
import APIManager

protocol GetCSRFTokenDataManagerContract {
    func getCSRFToken(_ method: UsecaseRequestMethod) async -> UsecaseResult<CSRFToken, Error>
}

class GetCSRFTokenDataManager: GetCSRFTokenDataManagerContract  {
    
    let networkService: GetCSRFTokenNetworkServiceContract
    
    init(networkService: GetCSRFTokenNetworkServiceContract) {
        self.networkService = networkService
    }
    
    func getCSRFToken(_ method: UsecaseRequestMethod) async -> UsecaseResult<CSRFToken, any Error> {
        switch method {
        case .local:
            return .failure(LError.NoLocalDataManager)
        case .remote:
            return await networkService.getCSRFToken()
        }
    }
    
}
