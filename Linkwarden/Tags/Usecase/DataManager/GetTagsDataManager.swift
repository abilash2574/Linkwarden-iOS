//
//  GetTagsDataManager.swift
//  Linkwarden
//
//  Created by Abilash S on 25/04/24.
//

import Foundation

protocol GetTagsDataManagerContract {
    
    func getTags(_ method: UsecaseRequestMethod) async -> UsecaseResult<TagsJsonBody, Error>
    
}

class GetTagsDataManager: GetTagsDataManagerContract {
    
    let networkService: GetTagsNetworkServiceContract
    
    init(networkService: GetTagsNetworkServiceContract) {
        self.networkService = networkService
    }
    
    func getTags(_ method: UsecaseRequestMethod) async -> UsecaseResult<TagsJsonBody, any Error> {
        switch method {
        case .local:
            return .failure(LError.NoLocalDataManager)
        case .remote:
            return await networkService.getTags()
        }
    }
    
}
