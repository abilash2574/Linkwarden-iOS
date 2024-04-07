//
//  GetSessionDetailUsecase.swift
//  Linkwarden
//
//  Created by Abilash S on 24/03/24.
//

import Foundation

class GetSessionDetailUsecase: Usecase<GetSessionDetailUsecase.Request, GetSessionDetailUsecase.Response> {
    
    let dataManager: GetSessionDetailDataManagerContract
    
    init(dataManager: GetSessionDetailDataManagerContract) {
        self.dataManager = dataManager
    }
    
    override func run(request: Request) async -> UsecaseResult<Response, any Error> {
        switch await dataManager.getSessionDetail(request.type) {
        case .success(let sessionDetail):
            return .success(.init(sessionDetail: sessionDetail))
        case .failure(let error):
            return .failure(error)
        }
    }
    
    class Request: UsecaseRequest {
        let type: UsecaseRequestMethod = .remote
    }
    
    class Response: UsecaseResponse {
        let sessionDetail: SessionDetail
        
        init(sessionDetail: SessionDetail) {
            self.sessionDetail = sessionDetail
        }
    }
    
}
