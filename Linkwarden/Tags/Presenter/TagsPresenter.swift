//
//  TagsPresenter.swift
//  Linkwarden
//
//  Created by Abilash S on 25/04/24.
//

import Foundation

protocol TagsPresenterContract {
    
    func viewOnAppearing()
    
}

class TagsPresenter: TagsPresenterContract {
    
    let getTags: GetTagsUsecase
    
    weak var viewState: TagsViewStateContract?
    
    var viewDidLoadTheFirstTime: Bool = false
    
    init(getTags: GetTagsUsecase) {
        self.getTags = getTags
    }
 
    func viewOnAppearing() {
        guard checkAndHandleNetworkConnectivity(), !viewDidLoadTheFirstTime else {
            return
        }
        
        Task {
            let tags = await getTags()
            guard !tags.isEmpty else {
                // TODO: ZVZV Handle empty Bookmarks
                return
            }
            await MainActor.run {
                viewState?.tags = tags
                viewDidLoadTheFirstTime = true
            }
        }
    }
    
}

extension TagsPresenter {
    
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
    
    private func getTags() async -> [Tag] {
        let request = GetTagsUsecase.Request()
        switch await getTags.execute(request: request) {
        case .success(let response):
            return response.tags
        case .failure(let error):
            LLogger.shared.error("\(error)")
            return []
        }
    }
    
}
