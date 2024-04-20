//
//  GetBookmarkPreviewNetworkManager.swift
//  Linkwarden
//
//  Created by Abilash S on 19/04/24.
//

import UIKit
import APIManager

protocol GetBookmarkPreviewNetworkManagerContract: NetworkServiceContract {
    
    func getBookmarkPreview(from previewURL: String) async -> UsecaseResult<UIImage, Error>
    
}

class GetBookmarkPreviewNetworkManager: GetBookmarkPreviewNetworkManagerContract {
    
    var urlString: String { "https://icons.duckduckgo.com/ip3" }
    
    func getBookmarkPreview(from previewURL: String) async -> UsecaseResult<UIImage, any Error> {
        
        let cacheKey = NSString(string: previewURL)
        
        if let image = imageCache.object(forKey: cacheKey) {
            LLogger.shared.info("Image for \(previewURL) from cache")
            return .success(image)
        }
        
        let iconURL = "\(urlString)/\(previewURL).ico"
        
        guard isOnline() else {
            return .failure(No_Network_API_Error)
        }
        
        guard let url = URL(string: iconURL) else {
            return .failure(APINetworkError.apiManagerError(status: APIErrorStatus.invalidURLString, message: LErrorMessage.Invalid_URL_String, info: nil))
        }
        
        switch await APIManager.makeRequest(.GET, withURL: url, headers: nil, requestBody: nil) {
        case .success(let data, let response):
            guard response.statusCode == 200 else {
                return .failure(APINetworkError.apiManagerError(status: APIErrorStatus.invalidResponseCode, message: LErrorMessage.Invalid_Response_Code, info: nil))
            }
            
            guard let image = UIImage(data: data) else {
                return .failure(APINetworkError.processingError(status: APIErrorStatus.invalidImageData, message: LErrorMessage.Invalid_Image_Data, info: nil))
            }
            
            imageCache.setObject(image, forKey: cacheKey)
            return .success(image)
        case .failure(let error):
            return .failure(error)
        }
    }
    
}
