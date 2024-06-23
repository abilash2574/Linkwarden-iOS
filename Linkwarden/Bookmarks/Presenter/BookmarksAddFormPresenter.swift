//
//  BookmarksAddFormPresenter.swift
//  Linkwarden
//
//  Created by Abilash S on 22/06/24.
//

import Foundation

protocol BookmarksAddFormPresenterContract: AnyObject {
    
    func viewOnAppearing()
    
}


class BookmarksAddFormPresenter: BookmarksAddFormPresenterContract {
    
    let addBookmarksUsecase: AddBookmarksUsecase
    
    weak var viewState: BookmarksAddFormStateContract?
    
    init(addBookmarksUsecase: AddBookmarksUsecase) {
        self.addBookmarksUsecase = addBookmarksUsecase
    }
    
    func viewOnAppearing() {
        
    }
    
}
