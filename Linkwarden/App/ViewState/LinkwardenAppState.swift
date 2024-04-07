//
//  LinkwardenAppState.swift
//  Linkwarden
//
//  Created by Abilash S on 24/03/24.
//

import Foundation

class LinkwardenAppState: ToastSupport, ObservableObject {
    
    static let shared = LinkwardenAppState()
    
    var containerView: ContainerView?
    
    @Published var showLogin = false
    @Published var showHomepage = false
    @Published var showLoading = true
    
    @Published var showToast = false
    var toastMessage: LocalizedStringResource = ""
    
    var getSessionUsecase = LinkwardenAssembler.getSessionDetailUsecase()
    
    /// Returns `true` if the session is valid and `false` if the session is invalid.
    var isSessionValid: Bool {
        get async {
            // TODO: ZVZV Update expiry date when the session API is hit
            guard let expiryDate = NetworkManager.sessionExpiry, expiryDate > Date() else {
                return false
            }
            return await validateSession()
        }
    }
    
    /// Validates the current session token is valid and stores the user id that is required for further usecases.
    /// - Returns: Returns a `Bool`.
    ///            `true` if the session is valid.
    ///            `false` if the session is invalid.
    private func validateSession() async -> Bool {
        let request = GetSessionDetailUsecase.Request()
        switch await getSessionUsecase.execute(request: request) {
        case .success(let session):
            AppState.userID = Int(session.sessionDetail.user.id)
            // TODO: Verify if the session expiry date received from this API is the updated expiry date that we receive when logging in.

            AppState.sessionExpiryDate = DateTimeManager.defaultDateFormatter.dateFormatter.date(from: session.sessionDetail.expires)
            if AppState.userID == nil || AppState.sessionExpiryDate == nil {
                showToast(with: "Oh no! We encountered an error while you were trying to log in.")
                LLogger.shared.critical("message: Insufficient Details received on hitting Session API")
                return false
            }
            return true
        case .failure(let error):
            LLogger.shared.critical("message: Session in valid with missing userID or session expiry.\nerror: \(error)")
            return false
        }
    }
    
}

/// public functions 
extension LinkwardenAppState {
    
    public func didLoginSuccessfully() {
        LinkwardenAppState.shared.showLogin = false
        LinkwardenAppState.shared.showHomepage = true
    }
    
    public func didLoginFailed() {
        LinkwardenAppState.shared.showHomepage = false
        LinkwardenAppState.shared.showLogin = true
    }
}
