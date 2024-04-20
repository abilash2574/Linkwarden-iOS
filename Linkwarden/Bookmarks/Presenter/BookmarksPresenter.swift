//
//  BookmarksPresenter.swift
//  Linkwarden
//
//  Created by Abilash S on 19/04/24.
//

import UIKit

protocol BookmarksPresenterContract {
    
    func viewOnAppearing()
    
}

class BookmarksPresenter: BookmarksPresenterContract {
    
    let getBookmarksUsecase: GetBookmarksUsecase
    
    let getAllBookmarksPreviewUsecase: GetAllBookmarksPreviewUsecase
    
    weak var viewState: BookmarksViewStateContract?
    
    init(getBookmarksUsecase: GetBookmarksUsecase, getAllBookmarksPreviewUsecase: GetAllBookmarksPreviewUsecase, viewState: BookmarksViewStateContract? = nil) {
        self.getBookmarksUsecase = getBookmarksUsecase
        self.getAllBookmarksPreviewUsecase = getAllBookmarksPreviewUsecase
        self.viewState = viewState
    }
    
    func viewOnAppearing() {
        guard checkAndHandleNetworkConnectivity() else { return }
        
        Task {
            let bookmarks = await getBookmarks()
            getBookmarkPreview(bookmarks)
            await MainActor.run {
                viewState?.bookmarks = bookmarks
            }
        }
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
    
    private func getBookmarks() async -> [Bookmark] {
        let request = GetBookmarksUsecase.Request(sortID: 0)
        switch await getBookmarksUsecase.execute(request: request) {
        case .success(let response):
            return response.bookmarks
        case .failure(let error):
            // TODO: ZVZV Handle empty error
            LLogger.shared.error("\(error)")
            return []
        }
    }
    
    private func getBookmarkPreview(_ bookmarks: [Bookmark]) {
        Task {
            switch await getAllBookmarksPreviewUsecase.execute(request: .init(bookmarks: bookmarks)) {
            case .success(let images):
                await MainActor.run {
                    for image in images.images {
                        let bookmark = viewState?.bookmarks.first(where: {$0.bookmarkID == image.0 })
                        bookmark?.previewImage = image.1
                    }
                }
            case .failure(_):
                break
            }
        }
    }

}
