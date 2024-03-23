//
//  SessionToken.swift
//  Linkwarden
//
//  Created by Abilash S on 24/03/24.
//

import Foundation

struct SessionToken: Codable {
    
    var cookieKey: String
    var cookieToken: String
    var expiryDate: Date
    
}
