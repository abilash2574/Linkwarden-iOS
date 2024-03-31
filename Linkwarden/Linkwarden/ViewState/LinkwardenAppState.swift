//
//  LinkwardenAppState.swift
//  Linkwarden
//
//  Created by Abilash S on 24/03/24.
//

import Foundation

class LinkwardenAppState: ObservableObject {
    
    static let shared = LinkwardenAppState()
    
    @Published var showLogin = false
    @Published var showHomepage = false
    @Published var showLoading = true
    
    var getSessionUsecase = LinkwardenAssembler.getSessionDetailUsecase()
    
    var isSessionValid: Bool {
        get async {
            guard let sessionToken = NetworkManager.sessionTokenCookie,  let expiryDate = sessionToken["ExpiryDate"] as? Date, expiryDate > Date() else {
                return false
            }
            return await validateSession()
        }
    }
    
    private func validateSession() async -> Bool {
        let request = GetSessionDetailUsecase.Request()
        switch await getSessionUsecase.execute(request: request) {
        case .success(let session):
            AppState.userID = Int(session.sessionDetail.user.id)
            AppState.sessionExpiryDate = DateTimeManager.defaultDateFormatter.dateFormatter.date(from: session.sessionDetail.expires)
            if AppState.userID == nil || AppState.sessionExpiryDate == nil {
                LLogger.shared.critical("Session in valid with missing userID or session expiry")
            }
            return true
        case .failure(let error):
            LLogger.shared.critical("Session is invalid")
            return false
        }
    }
    
}
