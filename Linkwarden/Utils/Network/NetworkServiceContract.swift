//
//  NetworkServiceContract.swift
//  Linkwarden
//
//  Created by Abilash S on 10/03/24.
//

import UIKit

protocol NetworkServiceContract: AnyObject { }

extension NetworkServiceContract {
    
    func isOnline() -> Bool {
        NetworkUtils.isNetworkAccessible
    }
    
    var imageCache: NSCache<NSString, UIImage> { NetworkManager.imageCache }
    
}
