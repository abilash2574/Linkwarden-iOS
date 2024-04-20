//
//  GetBookmarkPreviewUsecase.swift
//  Linkwarden
//
//  Created by Abilash S on 19/04/24.
//

import UIKit

class GetBookmarkPreviewUsecase: Usecase<GetBookmarkPreviewUsecase.Request, GetBookmarkPreviewUsecase.Response> {
    
    let dataManager: GetBookmarkPreviewDataManagerContract
    
    init(dataManager: GetBookmarkPreviewDataManagerContract) {
        self.dataManager = dataManager
    }
    
    override func run(request: Request) async -> UsecaseResult<Response, any Error> {
        switch await dataManager.getBookmarkPreview(request.type, url: request.url) {
        case .success(let image):
            return .success(.init(image: image))
        case .failure(let error):
            return .failure(error)
        }
    }
    
    class Request: UsecaseRequest {
        let type: UsecaseRequestMethod = .remote
        let url: String
        
        init(url: String) {
            self.url = url
        }
    }
    
    class Response: UsecaseResponse {
        let image: UIImage
        
        init(image: UIImage) {
            self.image = image
        }
    }
    
}
