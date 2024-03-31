//
//  GetSessionDetailsNetworkService.swift
//  Linkwarden
//
//  Created by Abilash S on 24/03/24.
//

import Foundation
import APIManager

protocol GetSessionDetailsNetworkServiceContract: NetworkServiceContract {

    func getSessionDetail() async -> UsecaseResult<SessionDetail, Error>
    
}

class GetSessionDetailsNetworkService: NSObject, GetSessionDetailsNetworkServiceContract {
    
    lazy var urlString = "\(NetworkManager.getBaseURL())\(NetworkManager.APIPath)/auth/session"
    
    func getSessionDetail() async -> UsecaseResult<SessionDetail, any Error> {
        guard isOnline() else {
            return .failure(No_Network_API_Error)
        }
        
        guard let url = URL(string: urlString) else {
            return .failure(APINetworkError.apiManagerError(status: APIErrorStatus.invalidURLString, message: LErrorMessage.Invalid_URL_String, info: nil))
        }
        
        guard let sessionToken = NetworkManager.sessionCookie else {
            return .failure(APINetworkError.apiManagerError(status: APIErrorStatus.invalidOperation, message: "Something went wrong", info: nil))
        }
        
        let headers = ["Content-Type" : "application/json; charset=utf-8", "Cookie": "\(sessionToken);"]
        
        switch await APIManager.makeRequest(.GET, withURL: url, headers: headers, requestBody: nil) {
        case .success(let data, let response):
            if response.statusCode == 200 {
                guard let session = try? JSONDecoder().decode(SessionDetail.self, from: data) else {
                    return .failure(APINetworkError.processingError(status: APIErrorStatus.invalidJSONResponse, message: LErrorMessage.Invalid_JSON_Process, info: nil))
                }
                return .success(session)
            } else {
                return .failure(APINetworkError.apiManagerError(status: APIErrorStatus.invalidResponseCode, message: LErrorMessage.Invalid_Response_Code, info: nil))
            }
        case .failure(let error):
            return .failure(error)
        }
    }
    
}
