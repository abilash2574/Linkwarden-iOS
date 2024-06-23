//
//  AddBookmarksDataManager.swift
//  Linkwarden
//
//  Created by Abilash S on 22/06/24.
//

protocol AddBookmarksDataManagerContract {
    
    func addBookmark(_ method: UsecaseRequestMethod, bookmark: BookmarkPostModel) async -> UsecaseResult<BookmarksJsonBody, Error>
    
}

class AddBookmarksDataManager: AddBookmarksDataManagerContract {
    
    let networkService: AddBookmarksNetworkServiceContract
    
    init(networkService: AddBookmarksNetworkServiceContract) {
        self.networkService = networkService
    }
    
    func addBookmark(_ method: UsecaseRequestMethod, bookmark: BookmarkPostModel) async -> UsecaseResult<BookmarksJsonBody, any Error> {
        switch method {
            case .local:
                return .failure(LError.NoLocalDataManager)
            case .remote:
                return await networkService.addBookmark(bookmark)
        }
    }
    
}
