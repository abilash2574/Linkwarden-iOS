//
//  GetCSRFTokenUsecase.swift
//  Linkwarden
//
//  Created by Abilash S on 10/03/24.
//

import Foundation

class GetCSRFTokenUsecase: Usecase<GetCSRFTokenUsecase.Request, GetCSRFTokenUsecase.Response> {
    
    let dataManager: GetCSRFTokenDataManagerContract
    
    init(dataManager: GetCSRFTokenDataManagerContract) {
        self.dataManager = dataManager
    }
    
    override func run(request: Request) async -> UsecaseResult<Response, any Error> {
        switch await dataManager.getCSRFToken(request.type) {
        case .success(let token):
            return .success(.init(token: token))
        case .failure(let error):
            return .failure(error)
        }
        
    }
    
    class Request: UsecaseRequest {
        let type: UsecaseRequestMethod = .remote
    }
    
    class Response: UsecaseResponse {
        let token: CSRFToken
        
        init(token: CSRFToken) {
            self.token = token
        }
    }
    
}
