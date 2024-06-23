//
//  GetBookmarksNetworkService.swift
//  Linkwarden
//
//  Created by Abilash S on 19/04/24.
//

import Foundation
import APIManager

protocol GetBookmarksNetworkServiceContract: NetworkServiceContract {
    
    func getBookmarks(sortID: Int64, tagID: Int64?, collectionID: Int64?) async -> UsecaseResult<BookmarksListJsonBody, Error>
    
}

class GetBookmarksNetworkService: NSObject, GetBookmarksNetworkServiceContract {
    
    var urlString: String { "\(NetworkManager.getBaseURL())\(NetworkManager.APIPath)/links"}
    lazy var headers = ["Content-Type" : "application/json; charset=utf-8"]
    
    func getBookmarks(sortID: Int64, tagID: Int64?, collectionID: Int64?) async -> UsecaseResult<BookmarksListJsonBody, any Error> {
        guard isOnline() else {
            return .failure(No_Network_API_Error)
        }
        
        var sortedURL = "\(urlString)?sort=\(sortID)"
        
        if let tagID {
            sortedURL += "&tagId=\(tagID)"
        } else if let collectionID {
            sortedURL += "&collectionId=\(collectionID)"
        }
        
        guard let url = URL(string: sortedURL) else {
            return .failure(APINetworkError.apiManagerError(status: APIErrorStatus.invalidURLString, message: LErrorMessage.Invalid_URL_String, info: nil))
        }
        
        guard let sessionToken = NetworkManager.sessionCookie else {
            return .failure(APINetworkError.apiManagerError(status: APIErrorStatus.invalidOperation, message: LErrorMessage.UnknownError, info: nil))
        }
        
        headers["Cookie"] = "\(sessionToken);"
        
        switch await APIManager.makeRequest(.GET, withURL: url, headers: headers, requestBody: nil) {
        case .success(let data, let response):
            guard response.statusCode == 200 else {
                return .failure(APINetworkError.apiManagerError(status: APIErrorStatus.invalidResponseCode, message: LErrorMessage.Invalid_Response_Code, info: nil))
            }
            
            guard let bookmarkJSON = try? JSONDecoder().decode(BookmarksListJsonBody.self, from: data) else {
                return .failure(APINetworkError.processingError(status: APIErrorStatus.invalidJSONResponse, message: LErrorMessage.Invalid_JSON_Process, info: nil))
            }
            
            return .success(bookmarkJSON)
            
        case .failure(let error):
            return .failure(error)
        }
    }
    
}
