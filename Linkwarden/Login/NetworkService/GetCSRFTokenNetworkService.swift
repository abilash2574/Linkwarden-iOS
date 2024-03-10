//
//  GetCSRFTokenNetworkService.swift
//  Linkwarden
//
//  Created by Abilash S on 10/03/24.
//

import Foundation
import APIManager

protocol GetCSRFTokenNetworkServiceContract: NetworkServiceContract {
    
    func getCSRFToken() async -> UsecaseResult<CSRFToken, Error>
    
}

class GetCSRFTokenNetworkService: NSObject, GetCSRFTokenNetworkServiceContract {
    
    let urlString =  "\(NetworkManager.getBaseURL())\(NetworkManager.APIPath)/auth/csrf"
    
    func getCSRFToken() async -> UsecaseResult<CSRFToken, Error> {
        guard isOnline() else {
            return .failure(No_Network_API_Error)
        }
        
        return await fetchCSRFToken()
    }
    
}

extension GetCSRFTokenNetworkService {
    
    private func fetchCSRFToken() async -> UsecaseResult<CSRFToken, Error> {
        
        guard let url = URL(string: urlString) else {
            return .failure(APINetworkError.apiManagerError(status: APIErrorStatus.invalidURLString, message: LErrorMessage.Invalid_URL_String, info: nil))
        }
        
        switch await APIManager.makeRequest(.GET, withURL: url, headers: [:], requestBody: nil) {
        case .success(let data, let response):
//            guard let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
//                return .failure(APINetworkError.processingError(status: APIErrorStatus.invalidJSONResponse, message: LErrorMessage.Invalid_JSON_Process, info: nil))
//            }
            
            if response.statusCode == 200 {
//                guard let csrfToken = (jsonData[APIResponseConstants.csrfToken]) as? String else {
//                    return .failure(APINetworkError.processingError(status: APIErrorStatus.invalidJSONKey, message: LErrorMessage.Invalid_JSON_Key, info: nil))
//                }
                return NetworkManager.decode(CSRFToken.self, from: data)
            } else {
                return .failure(APINetworkError.apiManagerError(status: APIErrorStatus.invalidResponseCode, message: LErrorMessage.Invalid_Response_Code, info: nil))
            }
            
        case .failure(let error):
            return .failure(error)
        }
        
        
        
    }
    
}
