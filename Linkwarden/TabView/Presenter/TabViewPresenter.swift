//
//  TabViewPresenter.swift
//  Linkwarden
//
//  Created by Abilash S on 01/04/24.
//

import Foundation

protocol TabViewPresenterContract: AnyObject {
    
    func viewOnAppearing()
    
}

class TabViewPresenter: TabViewPresenterContract {
    
    weak var viewState: TabViewStateContract?
    
    func viewOnAppearing() {
        setTabModules()
    }
    
}

extension TabViewPresenter {
    
    private func setTabModules() {
        let modulesList = getModulesList()
        viewState?.setModulesInTab(modulesList)
    }
    
    private func getModulesList() -> [Module] {
        return [
            .Bookmarks,
            .Collections,
            .Favourites,
            .Tags,
            .Settings
        ]
    }
    
}
