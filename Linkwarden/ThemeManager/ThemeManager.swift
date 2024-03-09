//
//  ThemeManager.swift
//  Linkwarden
//
//  Created by Abilash S on 09/03/24.
//

import Foundation
import SwiftUI

class ThemeManager {
    
    enum Theme {
        case theme1
    }
    
    private static var currentTheme: Theme = getCurrentTheme()
    
    static func getCurrentTheme() -> Theme {
        // TODO: ZVZV Use a Userdefault to store the current selected theme
        return Theme.theme1
    }
    
    static var label: Color {
        currentTheme.label
    }
    
    static var secondaryLabel: Color {
        currentTheme.secondaryLabel
    }
    
    static var tertiaryLabel: Color {
        currentTheme.tertiaryLabel
    }
    
}

extension ThemeManager.Theme {
    
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
    
}
