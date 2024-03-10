//
//  Usecase.swift
//  Linkwarden
//
//  Created by Abilash S on 10/03/24.
//

import Foundation

protocol UsecaseRequest { }
protocol UsecaseResponse { }

enum UsecaseRequestMethod {
    case local
    case remote
}

enum UsecaseResult<T, LError> {
    case success(T)
    case failure(Error)
}

class GetUsecaseRequest: UsecaseRequest {
    
    let type: UsecaseRequestMethod
    
    init(type: UsecaseRequestMethod) {
        self.type = type
    }
}

class GetUsecaseResponse: UsecaseResponse {
    
    let type: UsecaseRequestMethod
    
    init(type: UsecaseRequestMethod) {
        self.type = type
    }
}

class Usecase<Request: UsecaseRequest, Response: UsecaseResponse> {
    
    public final func execute(request: Request) async -> UsecaseResult<Response, Error> {
        return await executeResult(request: request)
    }
    
    private func executeResult(request: Request) async -> UsecaseResult<Response, Error> {
        return await self.run(request: request)
    }
    
    open func run(request: Request) async -> UsecaseResult<Response, Error> {
        /// Over ride this by the subclass
        return .failure(LError.UnImplementedUsecase)
    }
    
}
