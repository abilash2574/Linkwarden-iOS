//
//  BookmarksAddFormState.swift
//  Linkwarden
//
//  Created by Abilash S on 22/06/24.
//

import SwiftUI

protocol BookmarksAddFormStateContract: ToastSupport, AnyObject {
    
    var isOnline: Bool { get set }
    
    var bookmark: Bookmark? { get set }
    
}

class BookmarksAddFormState: BookmarksAddFormStateContract, ObservableObject {
    
    let presenter: BookmarksAddFormPresenterContract
    
    @Published var bookmark: Bookmark?
    
    @Published var isOnline: Bool = true
    
    @Published var showToast: Bool = false

    @Published var toastMessage: LocalizedStringResource = ""

    
    init(presenter: BookmarksAddFormPresenterContract) {
        self.presenter = presenter
    }
    
}
