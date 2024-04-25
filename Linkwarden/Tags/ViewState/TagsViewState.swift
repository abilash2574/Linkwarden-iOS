//
//  TagsViewState.swift
//  Linkwarden
//
//  Created by Abilash S on 25/04/24.
//

import Foundation

protocol TagsViewStateContract: AnyObject {
    
}

class TagsViewState: TagsViewStateContract, ObservableObject {
    
    let presenter: TagsPresenterContract
    
    init(presenter: TagsPresenterContract) {
        self.presenter = presenter
    }
    
}
