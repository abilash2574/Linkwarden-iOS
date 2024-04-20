//
//  DateTimeManager.swift
//  Linkwarden
//
//  Created by Abilash S on 31/03/24.
//

import Foundation

public enum DateTimeManager {
    
    case defaultDateFormatter
    case shortTime
    case mediumDate
    case mediumDateShortTime
    case relativeMediumDate
    case relativeMediumDateShortTime
    
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
    
    static var shortTimeFormatter = makeDateFormatter(timeStyle: .short)
    static var mediumDateFormatter = makeDateFormatter(dateStyle: .medium)
    static var mediumDateShortTimeFormatter = makeDateFormatter(dateStyle: .medium, timeStyle: .short)
    static var relativeMediumDateFormater = makeDateFormatter(dateStyle: .medium, relativeFormat: true)
    static var relativeMediumDateShortTimeFormatter = makeDateFormatter(dateStyle: .medium, timeStyle: .short, relativeFormat: true)
    
    var dateFormatter: DateFormatter {
        switch self {
        case .defaultDateFormatter:
            return DateTimeManager.defaultDateTimeFormatter
        case .shortTime:
            return Self.shortTimeFormatter
        case .mediumDate:
            return Self.mediumDateFormatter
        case .mediumDateShortTime:
            return Self.mediumDateShortTimeFormatter
        case .relativeMediumDate:
            return Self.relativeMediumDateFormater
        case .relativeMediumDateShortTime:
            return Self.relativeMediumDateShortTimeFormatter
        }
    }
    
    private static func makeDateFormatter(timeStyle: DateFormatter.Style) -> DateFormatter {
        return makeDateFormatter(dateStyle: .none, timeStyle: timeStyle, relativeFormat: false)
    }
    
    private static func makeDateFormatter(dateStyle: DateFormatter.Style, relativeFormat: Bool = false) -> DateFormatter {
        return makeDateFormatter(dateStyle: dateStyle, timeStyle: .none, relativeFormat: relativeFormat)
    }
    
    private static func makeDateFormatter(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style, relativeFormat: Bool = false) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle
        dateFormatter.locale = locale
        dateFormatter.timeZone = timeZone
        dateFormatter.doesRelativeDateFormatting = relativeFormat
        return dateFormatter
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
