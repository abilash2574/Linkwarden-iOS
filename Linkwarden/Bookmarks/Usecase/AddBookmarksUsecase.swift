//
//  AddBookmarksUsecase.swift
//  Linkwarden
//
//  Created by Abilash S on 22/06/24.
//

class AddBookmarksUsecase: Usecase<AddBookmarksUsecase.Request, AddBookmarksUsecase.Response> {
    
    let dataManager: AddBookmarksDataManagerContract
    let convertor: BookmarksConvertor
    
    init(dataManager: AddBookmarksDataManagerContract, convertor: BookmarksConvertor) {
        self.dataManager = dataManager
        self.convertor = convertor
    }
    
    override func run(request: Request) async -> UsecaseResult<Response, any Error> {
        switch await dataManager
            .addBookmark(request.type, bookmark: request.bookmark) {
        case .success(let bookmarkObject):
            let bookmarks = convertor.convertBookmarksModelToBookmarks([bookmarkObject.response])
            return .success(.init(bookmarks: bookmarks))
        case .failure(let error):
            print(error)
            return .failure(error)
        }
    }
    
    class Request: UsecaseRequest {
        let type: UsecaseRequestMethod = .remote
        let bookmark: BookmarkPostModel
        
        init(bookmark: BookmarkPostModel) {
            self.bookmark = bookmark
        }
    }
    
    class Response: UsecaseResponse {
        let bookmarks: [Bookmark]
        
        init(bookmarks: [Bookmark]) {
            self.bookmarks = bookmarks
        }
    }
    
}
