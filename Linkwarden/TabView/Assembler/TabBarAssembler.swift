//
//  TabBarAssembler.swift
//  Linkwarden
//
//  Created by Abilash S on 01/04/24.
//

import Foundation

class TabBarAssembler {
    
    static func getTabBar() -> TabBarView {
        let presenter = TabViewPresenter()
        let viewState = TabViewState(presenter: presenter)
        presenter.viewState = viewState
        
        return TabBarView(viewState: viewState) 
    }
    
}
