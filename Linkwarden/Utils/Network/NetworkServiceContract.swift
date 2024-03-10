//
//  NetworkServiceContract.swift
//  Linkwarden
//
//  Created by Abilash S on 10/03/24.
//

import Foundation

protocol NetworkServiceContract: AnyObject { }

extension NetworkServiceContract {
    
    func isOnline() -> Bool {
        NetworkUtils.isNetworkAccessible
    }
    
}
