//
//  BookmarksPresenter.swift
//  Linkwarden
//
//  Created by Abilash S on 19/04/24.
//

import UIKit

protocol BookmarksPresenterContract {
    
    func viewOnAppearing()
    
    func imageDidAppearFor(_ bookmarkID: Int64)
    
}

class BookmarksPresenter: BookmarksPresenterContract {
    
    let getBookmarksUsecase: GetBookmarksUsecase
    
    let getBookmarkPreviewUsecase: GetBookmarkPreviewUsecase
    
    var tagID: Int64?
    var collectionID: Int64?

    weak var viewState: BookmarksViewStateContract?
    
    var viewDidLoadTheFirstTime: Bool = false
    
    init(getBookmarksUsecase: GetBookmarksUsecase, getBookmarkPreviewUsecase: GetBookmarkPreviewUsecase, viewState: BookmarksViewStateContract? = nil) {
        self.getBookmarksUsecase = getBookmarksUsecase
        self.getBookmarkPreviewUsecase = getBookmarkPreviewUsecase
        self.viewState = viewState
    }
    
    func viewOnAppearing() {
        guard checkAndHandleNetworkConnectivity(), !viewDidLoadTheFirstTime else { return }
        
        Task {
            let bookmarks = await getBookmarks(tagID: tagID, collectionID: collectionID)
            guard !bookmarks.isEmpty else {
                // TODO: ZVZV Handle empty Bookmarks
                return
            }
            await MainActor.run {
                viewState?.bookmarks = bookmarks
                viewDidLoadTheFirstTime = true
            }
        }
    }
    
    func imageDidAppearFor(_ bookmarkID: Int64) {
        getBookmarkPreview(for: bookmarkID)
    }
    
}

extension BookmarksPresenter {
    
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
    
    private func getBookmarks(tagID: Int64? = nil, collectionID: Int64? = nil) async -> [Bookmark] {
        let request = GetBookmarksUsecase.Request(sortID: 0, tagID: tagID, collectionID: collectionID)
        switch await getBookmarksUsecase.execute(request: request) {
        case .success(let response):
            return response.bookmarks
        case .failure(let error):
            // TODO: ZVZV Handle empty error
            LLogger.shared.error("\(error)")
            return []
        }
    }
    
    private func getBookmarkPreview(for bookmarkID: Int64) {
        Task {
            guard let bookmark = viewState?.bookmarks.first(where: { $0.bookmarkID == bookmarkID } ) else {
                // TODO: ZVZV Handle this
                return
            }
            let request = GetBookmarkPreviewUsecase.Request(url: bookmark.URL.host() ?? "")
            switch await getBookmarkPreviewUsecase.execute(request: request) {
            case .success(let response):
                await MainActor.run {
                    bookmark.previewImage = response.image
                }
            case .failure(let error):
                await MainActor.run {
                    bookmark.previewImage = ImageConstants.bookmarkThumbnail
                }
                LLogger.shared.error("Preview Image API failed.\nError: \(error)")
            }
            
        }
    }

}
