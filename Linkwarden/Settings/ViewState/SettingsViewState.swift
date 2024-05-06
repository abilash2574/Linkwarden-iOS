//
//  SettingsViewState.swift
//  Linkwarden
//
//  Created by Abilash S on 28/04/24.
//

import Foundation

protocol SettingsViewStateContract: ToastSupport, AnyObject {
    
    var isOnline: Bool { get set }
    
    var user: User? { get set }
}

class SettingsViewState: SettingsViewStateContract, ObservableObject {
    
    @Published var selectedFormats = Set<SettingsArchiveFormats>() {
        didSet {
            print("\(selectedFormats)")
        }
    }
    @Published var allowDuplicateLink: Bool = false
    @Published var selectedLinkAction: SettingsDefaultLinkAction = .openLink {
        didSet {
            print("\(selectedLinkAction)")
        }
    }
    
    @Published var user: User?
    
    @Published var isOnline: Bool = true
    
    @Published var showToast: Bool = false
    @Published var toastMessage: LocalizedStringResource = ""
    
    let presenter: SettingsPresenterContract
    
    init(presenter: SettingsPresenterContract) {
        self.presenter = presenter
    }
    
}

extension SettingsViewState {
    
    func viewOnAppearing() {
        presenter.viewOnAppearing()
    }
}
