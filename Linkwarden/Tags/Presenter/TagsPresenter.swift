//
//  TagsPresenter.swift
//  Linkwarden
//
//  Created by Abilash S on 25/04/24.
//

import Foundation

protocol TagsPresenterContract {
    
}

class TagsPresenter: TagsPresenterContract {
    
    let getTags: GetTagsUsecase
    
    weak var viewState: TagsViewStateContract?
    
    init(getTags: GetTagsUsecase) {
        self.getTags = getTags
    }
    
}
