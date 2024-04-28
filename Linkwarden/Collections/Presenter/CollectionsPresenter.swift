//
//  CollectionsPresenter.swift
//  Linkwarden
//
//  Created by Abilash S on 27/04/24.
//

import Foundation

protocol CollectionsPresenterContract {
    
    func viewOnAppearing()
    
}

class CollectionsPresenter: CollectionsPresenterContract {
    
    let getCollections: GetCollectionsUsecase
    
    weak var viewState: CollectionsViewStateContract?
    
    var viewDidLoadTheFirstTime: Bool = false
    
    init(getCollections: GetCollectionsUsecase) {
        self.getCollections = getCollections
    }
    
    func viewOnAppearing() {
        guard checkAndHandleNetworkConnectivity(), !viewDidLoadTheFirstTime else {
            return
        }
        
        Task {
            let collections = await getCollections()
            guard !collections.isEmpty else {
                // TODO: ZVZV Handle empty Bookmarks
                return
            }
            await MainActor.run {
                viewState?.collections = collections
                viewDidLoadTheFirstTime = true
            }
        }
    }
    
}

extension CollectionsPresenter {
    
    /// This will check if the internet connection is available and if not will show the offline view.
    /// - Returns: Returns a Bool according to the result.
    private func checkAndHandleNetworkConnectivity() -> Bool {
        guard NetworkUtils.isNetworkAccessible else {
            viewState?.isOnline = false
            LLogger.shared.critical("Device is offline. No Internet connection.")
            return false
        }
        viewState?.isOnline = true
        return true
    }
    
    private func getCollections() async -> [Collection] {
        let request = GetCollectionsUsecase.Request()
        switch await getCollections.execute(request: request) {
        case .success(let response):
            return response.collections
        case .failure(let error):
            LLogger.shared.error("\(error)")
            return []
        }
    }
    
}
