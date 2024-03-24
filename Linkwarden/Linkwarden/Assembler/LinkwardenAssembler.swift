//
//  LinkwardenAssembler.swift
//  Linkwarden
//
//  Created by Abilash S on 24/03/24.
//

import Foundation

struct LinkwardenAssembler {
    
    static func getSessionDetailUsecase() -> GetSessionDetailUsecase {
        let networkService = GetSessionDetailsNetworkService()
        let datamanager = GetSessionDetailDataManager(networkService: networkService)
        return GetSessionDetailUsecase(dataManager: datamanager)
    }
    
}
