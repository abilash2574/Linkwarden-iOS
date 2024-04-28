//
//  GetCollectionsUsecase.swift
//  Linkwarden
//
//  Created by Abilash S on 27/04/24.
//

import Foundation

class GetCollectionsUsecase: Usecase<GetCollectionsUsecase.Request, GetCollectionsUsecase.Response> {
    
    let dataManager: GetCollectionsDataManagerContract
    let convertor: CollectionsConvertor
    
    init(dataManager: GetCollectionsDataManagerContract, convertor: CollectionsConvertor) {
        self.dataManager = dataManager
        self.convertor = convertor
    }
    
    override func run(request: Request) async -> UsecaseResult<Response, any Error> {
        switch await dataManager.getCollections(request.type) {
        case .success(let collectionObject):
            let collections = convertor.convertCollectionModelToCollection(collectionObject.response)
            return .success(.init(collections: collections))
        case .failure(let error):
            return .failure(error)
        }
    }
    
    class Request: UsecaseRequest {
        let type: UsecaseRequestMethod = .remote
    }
    
    class Response: UsecaseResponse {
        let collections: [Collection]
        
        init(collections: [Collection]) {
            self.collections = collections
        }
        
    }
    
}
