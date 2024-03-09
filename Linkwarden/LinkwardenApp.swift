//
//  LinkwardenApp.swift
//  Linkwarden
//
//  Created by Abilash S on 09/03/24.
//

import SwiftUI

@main
struct LinkwardenApp: App {
    var body: some Scene {
        WindowGroup {
            let view = LoginAssembler.getLoginPageView()
            return view
        }
    }
}
