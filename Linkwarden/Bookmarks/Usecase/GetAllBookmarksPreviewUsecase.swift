//
//  GetAllBookmarksPreviewUsecase.swift
//  Linkwarden
//
//  Created by Abilash S on 19/04/24.
//

import UIKit

class GetAllBookmarksPreviewUsecase: Usecase<GetAllBookmarksPreviewUsecase.Request, GetAllBookmarksPreviewUsecase.Response> {
    
    let usecase: GetBookmarkPreviewUsecase
    
    init(usecase: GetBookmarkPreviewUsecase) {
        self.usecase = usecase
    }
    
    override func run(request: Request) async -> UsecaseResult<Response, any Error> {
        var images = [(Int64, UIImage)]()
        for bookmark in request.bookmarks {
            let request = GetBookmarkPreviewUsecase.Request(url: bookmark.URL.host() ?? "")
            switch await usecase.execute(request: request) {
            case .success(let response):
                images.append((bookmark.bookmarkID, response.image))
            case .failure(let error):
                LLogger.shared.error("Bookmark Preview for ID: \(bookmark.bookmarkID) could not be loaded.\nError: \(error)")
            }
        }
        return .success(.init(images: images))
    }
    
    class Request: UsecaseRequest {
        let type: UsecaseRequestMethod = .remote
        let bookmarks: [Bookmark]
        
        init(bookmarks: [Bookmark]) {
            self.bookmarks = bookmarks
        }
    }
    
    class Response: UsecaseResponse {
        let images: [(Int64, UIImage)]
        
        init(images: [(Int64, UIImage)]) {
            self.images = images
        }
    }
    
}
