//
//  GetBookmarksDataManager.swift
//  Linkwarden
//
//  Created by Abilash S on 19/04/24.
//

import Foundation

protocol GetBookmarksDataManagerContract {
    
    func getBookmarks(_ method: UsecaseRequestMethod, sortID: Int) async -> UsecaseResult<BookmarksJsonBody, Error>
    
}

class GetBookmarksDataManager: GetBookmarksDataManagerContract {
    
    let networkService: GetBookmarksNetworkManagerContract
    
    init(networkService: GetBookmarksNetworkManagerContract) {
        self.networkService = networkService
    }
    
    func getBookmarks(_ method: UsecaseRequestMethod, sortID: Int) async -> UsecaseResult<BookmarksJsonBody, any Error> {
        switch method {
        case .local:
            return .failure(LError.NoLocalDataManager)
        case .remote:
            return await networkService.getBookmarks(sortID: sortID)
        }
    }
    
}
