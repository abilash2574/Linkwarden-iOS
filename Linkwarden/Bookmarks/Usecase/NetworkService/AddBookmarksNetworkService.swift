//
//  AddBookmarksNetworkService.swift
//  Linkwarden
//
//  Created by Abilash S on 22/06/24.
//

import Foundation
import APIManager

protocol AddBookmarksNetworkServiceContract: NetworkServiceContract {
    
    func addBookmark(_ bookmark: BookmarkPostModel) async -> UsecaseResult<BookmarksJsonBody, any Error> 
    
}

class AddBookmarksNetworkService: NSObject, AddBookmarksNetworkServiceContract {
    
    
    var urlString: String { "\(NetworkManager.getBaseURL())\(NetworkManager.APIPath)/links"}
    lazy var headers = ["Content-Type" : "application/json; charset=utf-8"]
    
    func addBookmark(_ bookmark: BookmarkPostModel) async -> UsecaseResult<BookmarksJsonBody, any Error> {
        guard isOnline() else {
            return .failure(No_Network_API_Error)
        }
        
        guard let url = URL(string: urlString) else {
            return .failure(APINetworkError.apiManagerError(status: APIErrorStatus.invalidURLString, message: LErrorMessage.Invalid_URL_String, info: nil))
        }
        
        guard let sessionToken = NetworkManager.sessionCookie else {
            return .failure(APINetworkError.apiManagerError(status: APIErrorStatus.invalidOperation, message: LErrorMessage.UnknownError, info: nil))
        }
        
        headers["Cookie"] = "\(sessionToken);"
        
        let encoder = JSONEncoder()
        
        do {
            let jsonData = try encoder.encode(bookmark)
            if let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [String: Any] {
                switch await APIManager.makeRequest(.POST, withURL: url, headers: headers, requestBody: jsonObject) {
                    case .success(let data, let response):
                        print(response.statusCode)
                        
                        guard let bookmarkJSON = try? JSONDecoder().decode(BookmarksJsonBody.self, from: data) else {
                            return .failure(APINetworkError.processingError(status: APIErrorStatus.invalidJSONResponse, message: LErrorMessage.Invalid_JSON_Process, info: nil))
                        }
                        
                        return .success(bookmarkJSON)
                        
                    case .failure(let error):
                        print(error)
                        return .failure(error)
                }
            } else {
                return .failure(APINetworkError.processingError(status: "", message: "Unable to convert new bookmark to JSON", info: nil))
            }
        } catch let error {
            print("error")
            return .failure(error)
        }
    }
    
    
}
