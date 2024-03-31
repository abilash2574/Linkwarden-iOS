//
//  AppState.swift
//  Linkwarden
//
//  Created by Abilash S on 31/03/24.
//

import Foundation
import SwiftUI

class AppState {
    
    static var calendar: Calendar = .current
    
    static var timeZone: TimeZone = .current {
        didSet {
            updateTimeZone()
        }
    }
    
    static var locale: Locale = .current {
        didSet {
            updateLocale()
        }
    }
    
    static var userID: Int?
    
    static var sessionExpiryDate: Date?
    
    @AppStorage(UserDefaultsKeys.appFirstOnboardingKey)
    static var appLaunchFirstTime: Bool = false
    
}

extension AppState {
    
    private static func updateTimeZone() {
        calendar.timeZone = timeZone
        DateTimeManager.update(timeZone: timeZone)
    }
    
    private static func updateLocale() {
        calendar.locale = locale
        DateTimeManager.update(locale: locale)
    }
    
}
