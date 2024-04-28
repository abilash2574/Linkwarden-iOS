//
//  CollectionAssembler.swift
//  Linkwarden
//
//  Created by Abilash S on 27/04/24.
//

import Foundation

struct CollectionsAssembler {
    
    static func getCollectionsUsecase() -> GetCollectionsUsecase {
        let networkService = GetCollectionsNetworkService()
        let dataManager = GetCollectionsDataManager(networkService: networkService)
        let convertor = CollectionsConvertor()
        let usecase = GetCollectionsUsecase(dataManager: dataManager, convertor: convertor)
        return usecase
    }
    
    static func getCollectionsView() -> CollectionsView {
        let usecase = getCollectionsUsecase()
        let presenter = CollectionsPresenter(getCollections: usecase)
        let viewState = CollectionsViewState(presenter: presenter)
        
        presenter.viewState = viewState
        
        let view = CollectionsView(viewState: viewState)
        
        return view
    }
}
