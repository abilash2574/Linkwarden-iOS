//
//  GetUserDataManager.swift
//  Linkwarden
//
//  Created by Abilash S on 28/04/24.
//

import Foundation

protocol GetUserDataManagerContract {
    
    func getUser(_ method: UsecaseRequestMethod, for id: Int64) async -> UsecaseResult<UserJsonBody, Error>
    
}

class GetUserDataManager: GetUserDataManagerContract {

    let networkService: GetUserNetworkServiceContract
    
    init(networkService: GetUserNetworkServiceContract) {
        self.networkService = networkService
    }
    
    func getUser(_ method: UsecaseRequestMethod, for id: Int64) async -> UsecaseResult<UserJsonBody, any Error> {
        switch method {
        case .local:
            return .failure(LError.NoLocalDataManager)
        case .remote:
            return await networkService.getUser(for: id)
        }
    }
    
}
