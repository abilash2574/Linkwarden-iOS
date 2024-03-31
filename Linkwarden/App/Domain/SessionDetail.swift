//
//  SessionDetail.swift
//  Linkwarden
//
//  Created by Abilash S on 24/03/24.
//

import Foundation

struct SessionDetail: Codable {
    
    struct User: Codable {
        var id: Int64
    }
    
    var user: User
    var expires: String
    
}
