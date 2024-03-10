//
//  NetworkUtils.swift
//  Linkwarden
//
//  Created by Abilash S on 10/03/24.
//

import Foundation

class NetworkUtils {
    
//    private static let hostAccessibility = Reachability(hostname: "")
    private static let accessibility = try? Reachability()
    private static var isConnectionAvailable = true
    
    static func startObserving() {
        accessibility?.whenReachable = { accessibility in
            LLogger.shared.info("Network Connection Accessible")
            self.isConnectionAvailable = true
        }
        
        accessibility?.whenUnreachable = { accessibility in
            LLogger.shared.warning("Network Connection Unreachable")
            self.isConnectionAvailable = false
            
        }
        
        do {
            try accessibility?.startNotifier()
        } catch let error {
            LLogger.shared.error("Unable to start Accessibilty Notifier: \(error)")
        }
    }
    
    static var isNetworkAccessible: Bool {
        return Self.isConnectionAvailable
    }
    
    static func stopObserving() {
        accessibility?.stopNotifier()
    }
    
}
