//
//  SettingsFormat.swift
//  Linkwarden
//
//  Created by Abilash S on 06/05/24.
//

import Foundation

enum SettingsArchiveFormats: String {
    case screenshots = "Screenshots"
    case pdf = "PDF"
    case archive = "Archive"
}

extension SettingsArchiveFormats: CaseIterable { }

enum SettingsDefaultLinkAction: String {
    case openLink  = "Open Link"
    case openPDF = "Open PDF"
    case openReadable = "Open Readable"
    case openScreenshot = "Open Screenshot"
}

extension SettingsDefaultLinkAction: CaseIterable { }
