//
//  GetBookmarksDataManager.swift
//  Linkwarden
//
//  Created by Abilash S on 19/04/24.
//

import Foundation

protocol GetBookmarksDataManagerContract {
    
    func getBookmarks(_ method: UsecaseRequestMethod, sortID: Int64, tagID: Int64?, collectionID: Int64?) async -> UsecaseResult<BookmarksListJsonBody, Error>
    
}

class GetBookmarksDataManager: GetBookmarksDataManagerContract {
    
    let networkService: GetBookmarksNetworkServiceContract
    
    init(networkService: GetBookmarksNetworkServiceContract) {
        self.networkService = networkService
    }
    
    func getBookmarks(_ method: UsecaseRequestMethod, sortID: Int64, tagID: Int64?, collectionID: Int64?) async -> UsecaseResult<BookmarksListJsonBody, any Error> {
        switch method {
            case .local:
                return .failure(LError.NoLocalDataManager)
            case .remote:
                return await networkService.getBookmarks(sortID: sortID, tagID: tagID, collectionID: collectionID)
        }
    }
    
}
