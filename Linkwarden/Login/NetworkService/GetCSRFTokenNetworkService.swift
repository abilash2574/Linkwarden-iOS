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
    
    lazy var urlString = "\(NetworkManager.getBaseURL())\(NetworkManager.APIPath)/auth/csrf"
    
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
            
            if response.statusCode == 200 {
                
                let responseCookies = HTTPCookie.cookies(withResponseHeaderFields: response.allHeaderFields as! [String: String], for: url)
                
                guard let key = responseCookies.first?.name, key == "__Host-next-auth.csrf-token" else {
                    return .failure(APINetworkError.apiManagerError(status: APIErrorStatus.internalError, message: "Cookie Not found", info: nil))
                }
                
                guard let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String : Any], let csrfToken = jsonObject["csrfToken"] as? String else {
                    return .failure(APINetworkError.processingError(status: APIErrorStatus.invalidOperation, message: "Parsing failed", info: nil))
                }
                
                let token = CSRFToken(csrfToken: csrfToken, cookieKey: responseCookies[0].name, cookieValue: responseCookies[0].value)
                
                return .success(token)
            } else {
                return .failure(APINetworkError.apiManagerError(status: APIErrorStatus.invalidResponseCode, message: LErrorMessage.Invalid_Response_Code, info: nil))
            }
            
        case .failure(let error):
            return .failure(error)
        }
        
        
        
    }
    
}
