//
//  GetCollectionsDataManager.swift
//  Linkwarden
//
//  Created by Abilash S on 27/04/24.
//

import Foundation

protocol GetCollectionsDataManagerContract {
    
    func getCollections(_ method: UsecaseRequestMethod) async -> UsecaseResult<CollectionsJsonBody, Error>
    
}

class GetCollectionsDataManager: GetCollectionsDataManagerContract {
    
    let networkService: GetCollectionsNetworkServiceContract
    
    init(networkService: GetCollectionsNetworkServiceContract) {
        self.networkService = networkService
    }
    
    func getCollections(_ method: UsecaseRequestMethod) async -> UsecaseResult<CollectionsJsonBody, any Error> {
        switch method {
        case .local:
            return .failure(LError.NoLocalDataManager)
        case .remote:
            return await networkService.getCollections()
        }
    }
}
