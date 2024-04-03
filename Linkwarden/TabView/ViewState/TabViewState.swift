//
//  TabViewState.swift
//  Linkwarden
//
//  Created by Abilash S on 01/04/24.
//

import Foundation

protocol TabViewStateContract: AnyObject {
    
    func setModulesInTab(_ modulesList: [Module])
    
}

class TabViewState: TabViewStateContract, ObservableObject {
    
    var presenter: TabViewPresenterContract
    
    @Published var modulesList = [Module]()
    
    init(presenter: TabViewPresenterContract) {
        self.presenter = presenter
    }
    
    func setModulesInTab(_ modulesList: [Module]) {
        self.modulesList = modulesList
    }
    
}

extension TabViewState {
    
    func viewOnAppearing() {
        presenter.viewOnAppearing()
    }
    
}
