//
//  ThemeManager.swift
//  Linkwarden
//
//  Created by Abilash S on 09/03/24.
//

import Foundation
import SwiftUI

class ThemeManager {
    
    @UserDefault(UserDefaultsKeys.currentThemeKey)
    private static var theme: String?
    
    enum Theme: String {
        case theme1
    }
    
    private static var currentTheme = getCurrentTheme()
    
    static func getCurrentTheme() -> Theme {
        guard let theme = theme, let _currentTheme = Theme.init(rawValue: theme) else {
            return Theme.theme1
        }
        
        return _currentTheme
    }
    
    static func setCurrentTheme(_ theme: Theme) {
        // TODO: Check if theme get changed on calling this function.
        ThemeManager.theme = theme.rawValue
    }
    
    // MARK: - Label
    static var label: Color { currentTheme.label }
    
    static var secondaryLabel: Color { currentTheme.secondaryLabel }
    
    static var tertiaryLabel: Color { currentTheme.tertiaryLabel }
    
    // MARK: - Background
    static var background: Color { currentTheme.background }
    
    static var secondaryBackground: Color { currentTheme.secondaryBackground }

    // MARK: - Standard Colors
    static var white: Color { currentTheme.white }
    
    // MARK: - AccentTint
    static var tint: Color { currentTheme.tint }

    // MARK: - Gradients

    static var gradientAStartPoint: Color { currentTheme.gradientAStartPoint }
    
    static var gradientAEndPoint: Color { currentTheme.gradientAEndPoint }
    
}

extension ThemeManager.Theme {
    
    // MARK: - Label

    var label: Color {
        switch self {
        default:
            Color(UIColor.label)
        }
    }
    
    var secondaryLabel: Color {
        switch self {
        default:
            Color(UIColor.secondaryLabel)
        }
    }
    
    var tertiaryLabel: Color {
        switch self {
        default:
            Color(UIColor.tertiaryLabel)
        }
    }
    
    // MARK: - Background

    var background: Color {
        switch self {
        case .theme1:
            Color.themeABackground
        }
    }
    
    var secondaryBackground: Color {
        switch self {
        case .theme1:
            Color.themeASecondaryBackground
        }
    }
    
    // MARK: - Standard Colors

    var white: Color {
        switch self {
        default:
            Color.white
        }
    }
    
    // MARK: - Accent Tint
    
    var tint: Color {
        switch self {
        default:
            Color.accentColor
        }
    }
    
    // MARK: - Gradients
    
    var gradientAStartPoint: Color {
        switch self {
        case .theme1:
            Color.themeAGradientAStart
        }
    }
    
    var gradientAEndPoint: Color {
        switch self {
        case .theme1:
            Color.themeAGradientAEnd
        }
    }

}
