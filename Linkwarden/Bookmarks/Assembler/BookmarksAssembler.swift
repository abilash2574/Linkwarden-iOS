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
    
    static func getBookmarksView(tagID: Int64? = nil, collectionID: Int64? = nil) -> BookmarksView {
        let usecase = Self.getBookmarksUsecase()
        let previewUsecase = Self.getBookmarkPreviewUsecase()
        
        let presenter = BookmarksPresenter(getBookmarksUsecase: usecase, getBookmarkPreviewUsecase: previewUsecase)
        presenter.tagID = tagID
        presenter.collectionID = collectionID

        let viewState = BookmarksViewState(presenter: presenter)
        presenter.viewState = viewState
        
        let bookmarksView = BookmarksView(viewState: viewState)
        return bookmarksView
    }
    
    static func getBookmarksAddFormView() -> BookmarksAddFormView {
        let service = AddBookmarksNetworkService()
        let datamanager = AddBookmarksDataManager(networkService: service)
        let convertor = BookmarksConvertor()
        let usecase = AddBookmarksUsecase(dataManager: datamanager, convertor: convertor)
        
        let presenter = BookmarksAddFormPresenter(addBookmarksUsecase: usecase)
        
        let viewState = BookmarksAddFormState(presenter: presenter)
        presenter.viewState = viewState
        
        let view = BookmarksAddFormView(viewState: viewState)
        
        return view
    }
    
}
