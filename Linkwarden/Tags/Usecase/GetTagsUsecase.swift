//
//  GetTagsUsecase.swift
//  Linkwarden
//
//  Created by Abilash S on 25/04/24.
//

import Foundation

class GetTagsUsecase: Usecase<GetTagsUsecase.Request, GetTagsUsecase.Response> {
    
    let dataManager: GetTagsDataManagerContract
    let convertor: TagsConvertor
    
    init(dataManager: GetTagsDataManagerContract, convertor: TagsConvertor) {
        self.dataManager = dataManager
        self.convertor = convertor
    }
    
    override func run(request: Request) async -> UsecaseResult<Response, any Error> {
        switch await dataManager.getTags(request.type) {
        case .success(let tagsObject):
            let tags = convertor.convertTagsModelToTags(tagsObject.response)
            return .success(.init(tags: tags))
        case .failure(let error):
            return .failure(error)
        }
    }
    
    class Request: UsecaseRequest {
        let type: UsecaseRequestMethod = .remote
    }
    
    class Response: UsecaseResponse {
        let tags: [Tags]
        
        init(tags: [Tags]) {
            self.tags = tags
        }
    }
    
}
