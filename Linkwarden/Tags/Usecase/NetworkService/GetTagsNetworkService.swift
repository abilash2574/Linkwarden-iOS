//
//  GetTagsNetworkService.swift
//  Linkwarden
//
//  Created by Abilash S on 25/04/24.
//

import Foundation
import APIManager

protocol GetTagsNetworkServiceContract: NetworkServiceContract {
    
    func getTags() async -> UsecaseResult<TagsJsonBody, Error>
    
}

class GetTagsNetworkService: NSObject, GetTagsNetworkServiceContract {
    
    var urlString: String { "\(NetworkManager.getBaseURL())\(NetworkManager.APIPath)/tags"}
    lazy var headers = ["Content-Type" : "application/json; charset=utf-8"]
    
    func getTags() async -> UsecaseResult<TagsJsonBody, any Error> {
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
        
        switch await APIManager.makeRequest(.GET, withURL: url, headers: headers, requestBody: nil) {
        case .success(let data, let response):
            guard response.statusCode == 200 else {
                return .failure(APINetworkError.apiManagerError(status: APIErrorStatus.invalidResponseCode, message: LErrorMessage.Invalid_Response_Code, info: nil))
            }
            
            guard let tagsJSON = try? JSONDecoder().decode(TagsJsonBody.self, from: data) else {
                return .failure(APINetworkError.processingError(status: APIErrorStatus.invalidJSONResponse, message: LErrorMessage.Invalid_JSON_Process, info: nil))
            }
            
            return .success(tagsJSON)
            
        case .failure(let error):
            return .failure(error)
        }
    }
    
}
