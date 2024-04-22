//
//  BookmarksAssembler.swift
//  Linkwarden
//
//  Created by Abilash S on 19/04/24.
//

import Foundation

struct BookmarksAssembler {
    
    static func getBookmarkPreviewUsecase() -> GetBookmarkPreviewUsecase {
        let networkService = GetBookmarkPreviewNetworkService()
        let dataManager = GetBookmarkPreviewDataManager(networkService: networkService)
        return GetBookmarkPreviewUsecase(dataManager: dataManager)
    }
    
    static func getAllBookmarksPreviewUsecase() -> GetAllBookmarksPreviewUsecase {
        let usecase = Self.getBookmarkPreviewUsecase()
        return GetAllBookmarksPreviewUsecase(usecase: usecase)
    }
    
    static func getBookmarkConvertor() -> BookmarksConvertor {
        let convertor = BookmarksConvertor()
        return convertor
    }
    
    static func getBookmarksUsecase() -> GetBookmarksUsecase {
        let networkService = GetBookmarksNetworkService()
        let dataManager = GetBookmarksDataManager(networkService: networkService)
        let convertor = Self.getBookmarkConvertor()
        return GetBookmarksUsecase(dataManager: dataManager, convertor: convertor)
    }
    
    static func getBookmarksView() -> BookmarksView {
        let usecase = Self.getBookmarksUsecase()
        let previewUsecase = Self.getBookmarkPreviewUsecase()
        
        let presenter = BookmarksPresenter(getBookmarksUsecase: usecase, getBookmarkPreviewUsecase: previewUsecase)
        
        let viewState = BookmarksViewState(presenter: presenter)
        presenter.viewState = viewState
        
        let bookmarksView = BookmarksView(viewState: viewState)
        return bookmarksView
    }
    
}
