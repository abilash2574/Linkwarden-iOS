//
//  GetUserUsecase.swift
//  Linkwarden
//
//  Created by Abilash S on 28/04/24.
//

import Foundation

class GetUserUsecase: Usecase<GetUserUsecase.Request, GetUserUsecase.Response> {
    
    let dataManager: GetUserDataManagerContract
    let convertor: UserConvertor
    
    init(dataManager: GetUserDataManagerContract, convertor: UserConvertor) {
        self.dataManager = dataManager
        self.convertor = convertor
    }
    
    override func run(request: Request) async -> UsecaseResult<Response, any Error> {
        switch await dataManager.getUser(request.type, for: request.usedID) {
        case .success(let userObject):
            guard let user = convertor.convertUserModelToUser(userObject.response) else {
                return .failure(LError.UnableToConvertModel)
            }
            return .success(.init(user: user))
        case .failure(let error):
            return .failure(error)
        }
    }
    
    class Request: UsecaseRequest {
        let usedID: Int64
        let type: UsecaseRequestMethod
        
        init(usedID: Int64, type: UsecaseRequestMethod) {
            self.usedID = usedID
            self.type = type
        }
        
    }
    
    class Response: UsecaseResponse {
        let user: User
        
        init(user: User) {
            self.user = user
        }
        
    }
    
}
