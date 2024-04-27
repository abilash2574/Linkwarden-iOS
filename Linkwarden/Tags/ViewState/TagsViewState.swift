//
//  TagsViewState.swift
//  Linkwarden
//
//  Created by Abilash S on 25/04/24.
//

import Foundation

protocol TagsViewStateContract: ToastSupport, AnyObject {
    
    var isOnline: Bool { get set }
    
    var tags: [Tag] { get set }
    
}

class TagsViewState: TagsViewStateContract, ObservableObject {
    
    @Published var tags = [Tag]()
    
    @Published var isOnline: Bool = true
    
    @Published var showToast: Bool = false
    @Published var toastMessage: LocalizedStringResource = ""
    
    let presenter: TagsPresenterContract
    
    init(presenter: TagsPresenterContract) {
        self.presenter = presenter
    }
    
}

extension TagsViewState {
    
    func viewOnAppearing() {
        presenter.viewOnAppearing()
    }
    
}
