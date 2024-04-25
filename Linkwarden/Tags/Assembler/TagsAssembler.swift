//
//  TagsAssembler.swift
//  Linkwarden
//
//  Created by Abilash S on 25/04/24.
//

import Foundation

struct TagsAssembler {
    
    static func getTagsUsecase() -> GetTagsUsecase {
        let networkService = GetTagsNetworkService()
        let dataManger = GetTagsDataManager(networkService: networkService)
        let convertor = TagsConvertor()
        let usecase = GetTagsUsecase(dataManager: dataManger, convertor: convertor)
        return usecase
    }
    
    static func getTagsView() -> TagsView {
        let usecase = getTagsUsecase()
        let presenter = TagsPresenter(getTags: usecase)
        let viewState = TagsViewState(presenter: presenter)
        
        presenter.viewState = viewState
        
        let view = TagsView(viewState: viewState)

        return view
    }
    
}
