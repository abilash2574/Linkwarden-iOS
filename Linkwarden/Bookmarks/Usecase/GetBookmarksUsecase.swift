//
//  GetBookmarksUsecase.swift
//  Linkwarden
//
//  Created by Abilash S on 19/04/24.
//

import Foundation

class GetBookmarksUsecase: Usecase<GetBookmarksUsecase.Request, GetBookmarksUsecase.Response> {
    
    let dataManager: GetBookmarksDataManagerContract
    let convertor: BookmarksConvertor
    
    init(dataManager: GetBookmarksDataManagerContract, convertor: BookmarksConvertor) {
        self.dataManager = dataManager
        self.convertor = convertor
    }
    
    override func run(request: Request) async -> UsecaseResult<Response, any Error> {
        switch await dataManager.getBookmarks(request.type, sortID: request.sortID) {
        case .success(let bookmarkObject):
            let bookmarks = convertor.convertBookmarksModelToBookmarks(bookmarkObject.response)
            return .success(.init(bookmarks: bookmarks))
        case .failure(let error):
            print(error)
            return .failure(error)
        }
    }
    
    class Request: UsecaseRequest {
        let type: UsecaseRequestMethod = .remote
        let sortID: Int
        
        init(sortID: Int) {
            self.sortID = sortID
        }
    }
    
    class Response: UsecaseResponse {
        let bookmarks: [Bookmark]
        
        init(bookmarks: [Bookmark]) {
            self.bookmarks = bookmarks
        }
    }
    
}
