//
//  GetBookmarksNetworkService.swift
//  Linkwarden
//
//  Created by Abilash S on 19/04/24.
//

import Foundation
import APIManager

protocol GetBookmarksNetworkServiceContract: NetworkServiceContract {
    
    func getBookmarks(sortID: Int) async -> UsecaseResult<BookmarksJsonBody, Error>
    
}

class GetBookmarksNetworkService: NSObject, GetBookmarksNetworkServiceContract {
    
    var urlString: String { "\(NetworkManager.getBaseURL())\(NetworkManager.APIPath)/links"}
    lazy var headers = ["Content-Type" : "application/json; charset=utf-8"]
    
    func getBookmarks(sortID: Int) async -> UsecaseResult<BookmarksJsonBody, any Error> {
        guard isOnline() else {
            return .failure(No_Network_API_Error)
        }
        
        let sortedURL = "\(urlString)?sort=\(sortID)"
        
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
            
            guard let bookmarkJSON = try? JSONDecoder().decode(BookmarksJsonBody.self, from: data) else {
                return .failure(APINetworkError.processingError(status: APIErrorStatus.invalidJSONResponse, message: LErrorMessage.Invalid_JSON_Process, info: nil))
            }
            
            return .success(bookmarkJSON)
            
        case .failure(let error):
            return .failure(error)
        }
    }
    
}
