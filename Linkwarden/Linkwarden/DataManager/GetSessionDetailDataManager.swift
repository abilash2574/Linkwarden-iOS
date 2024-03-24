//
//  GetSessionDetailDataManager.swift
//  Linkwarden
//
//  Created by Abilash S on 24/03/24.
//

import Foundation

protocol GetSessionDetailDataManagerContract {
    
    func getSessionDetail(_ method: UsecaseRequestMethod) async -> UsecaseResult<SessionDetail, Error>
    
}

class GetSessionDetailDataManager: GetSessionDetailDataManagerContract  {
    
    let networkService: GetSessionDetailsNetworkServiceContract
    
    init(networkService: GetSessionDetailsNetworkServiceContract) {
        self.networkService = networkService
    }
    
    func getSessionDetail(_ method: UsecaseRequestMethod) async -> UsecaseResult<SessionDetail, any Error> {
        switch method {
        case .local:
            return .failure(LError.NoLocalDataManager)
        case .remote:
            return await networkService.getSessionDetail()
        }
    }
    
}
