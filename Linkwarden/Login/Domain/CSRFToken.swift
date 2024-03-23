//
//  CSRFToken.swift
//  Linkwarden
//
//  Created by Abilash S on 10/03/24.
//

import Foundation

struct CSRFToken: Codable {
    
    let csrfToken: String
    let cookieKey: String?
    let cookieValue: String?
    
    enum CodingKeys: String, CodingKey {
        case csrfToken
        case cookieKey
        case cookieValue
    }
    
    init(csrfToken: String, cookieKey: String? = nil, cookieValue: String? = nil) {
        self.csrfToken = csrfToken
        self.cookieKey = cookieKey
        self.cookieValue = cookieValue
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.csrfToken = try container.decode(String.self, forKey: .csrfToken)
        self.cookieKey = try container.decodeIfPresent(String.self, forKey: .cookieKey)
        self.cookieValue = try container.decodeIfPresent(String.self, forKey: .cookieValue)
    }
    
}
