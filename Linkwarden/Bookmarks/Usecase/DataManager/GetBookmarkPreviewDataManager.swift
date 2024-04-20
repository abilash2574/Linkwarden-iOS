//
//  GetBookmarkPreviewDataManager.swift
//  Linkwarden
//
//  Created by Abilash S on 19/04/24.
//

import UIKit

protocol GetBookmarkPreviewDataManagerContract {
    
    func getBookmarkPreview(_ method: UsecaseRequestMethod, url: String) async -> UsecaseResult<UIImage, Error>
    
}

class GetBookmarkPreviewDataManager: GetBookmarkPreviewDataManagerContract {
    
    let networkService: GetBookmarkPreviewNetworkServiceContract
    
    init(networkService: GetBookmarkPreviewNetworkServiceContract) {
        self.networkService = networkService
    }
    
    func getBookmarkPreview(_ method: UsecaseRequestMethod, url: String) async -> UsecaseResult<UIImage, any Error> {
        switch method {
        case .local:
            return .failure(LError.NoLocalDataManager)
        case .remote:
            return await networkService.getBookmarkPreview(from: url)
        }
    }
    
}
