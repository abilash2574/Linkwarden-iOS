//
//  Validator.swift
//  Linkwarden
//
//  Created by Abilash S on 31/03/24.
//

import Foundation

struct Validator {
    
    private static func checkRegex(_ text: String, pattern: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            return false
        }
        
        let range = NSRange(location: 0, length: text.utf16.count)
        return regex.firstMatch(in: text, range: range) != nil
    }
    
    static func isValidDomainURL(_ url: String) -> Bool {
        let domainRegex = #"^(https?://)?([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}(/[^\s]*)?$"#
        
        return checkRegex(url, pattern: domainRegex)
    }
    
    static func isValidIPv4Address(_ url: String) -> Bool {
        let ipv4Regex = #"\b(?:https?:\/\/)?(?:\d{1,3}\.){3}\d{1,3}(?::\d{1,5}(?!\d))?\b"#
        
        return checkRegex(url, pattern: ipv4Regex)
    }
    
    static func isValidIPv6Address(_ url: String) -> Bool {
        let ipv6Regex = #"\b(?:https?:\/\/)?(?:[0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}(?::\d{1,5}(?!\d))?\b"#
        
        return checkRegex(url, pattern: ipv6Regex)
    }
    
}
