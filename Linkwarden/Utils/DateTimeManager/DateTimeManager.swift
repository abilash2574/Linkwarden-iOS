//
//  DateTimeManager.swift
//  Linkwarden
//
//  Created by Abilash S on 31/03/24.
//

import Foundation

public enum DateTimeManager {
    
    case defaultDateFormatter
    
    static var timeZone = AppState.timeZone
    static var locale = AppState.locale
    static var calendar = AppState.calendar
    
    
    static var defaultDateTimeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = AppState.timeZone
        dateFormatter.locale = Locale(identifier: AppConstants.LOCALE_STANDARD)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter
    }()
    
    var dateFormatter: DateFormatter {
        switch self {
        case .defaultDateFormatter:
            return DateTimeManager.defaultDateTimeFormatter
        }
    }
    
    
}

extension DateTimeManager {
    
    static func update(timeZone: TimeZone) {
        self.timeZone = timeZone
        self.calendar.timeZone = timeZone
    }
    
    static func update(locale: Locale) {
        self.locale = locale
        self.calendar.locale = locale
    }
    
}
