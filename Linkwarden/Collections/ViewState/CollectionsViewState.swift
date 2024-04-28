//
//  CollectionsViewState.swift
//  Linkwarden
//
//  Created by Abilash S on 27/04/24.
//

import Foundation

protocol CollectionsViewStateContract: ToastSupport, AnyObject {
    
    var isOnline: Bool { get set }
    
    var collections: [Collection] { get set }
    
}

class CollectionsViewState: CollectionsViewStateContract, ObservableObject {
    
    @Published var collections = [Collection]()
    
    @Published var isOnline: Bool = true
    
    @Published var showToast: Bool = false
    @Published var toastMessage: LocalizedStringResource = ""
    
    let presenter: CollectionsPresenterContract
    
    init(presenter: CollectionsPresenterContract) {
        self.presenter = presenter
    }
    
}

extension CollectionsViewState {
    
    func viewOnAppearing() {
        presenter.viewOnAppearing()
    }
    
}
