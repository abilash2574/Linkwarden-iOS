//
//  BookmarksViewState.swift
//  Linkwarden
//
//  Created by Abilash S on 19/04/24.
//

import Foundation

protocol BookmarksViewStateContract: ToastSupport, AnyObject {
    
    var isOnline: Bool { get set }
    
    var bookmarks: [Bookmark] { get set }
    
}

class BookmarksViewState: BookmarksViewStateContract, ObservableObject {
    
    @Published var bookmarks: [Bookmark] = []
    
    @Published var isOnline: Bool = true
    
    @Published var showToast: Bool = false
    @Published var toastMessage: LocalizedStringResource = ""
    
    var presenter: BookmarksPresenterContract
    
    init(presenter: BookmarksPresenterContract) {
        self.presenter = presenter
    }
    
}

extension BookmarksViewState {
    
    func viewOnAppearing() {
        presenter.viewOnAppearing()
    }
    
    func imageViewOnAppear(_ bookmarkID: Int64) {
        presenter.imageDidAppearFor(bookmarkID)
    }
    
}

extension BookmarksViewState {
 
}
