//
//  VolUtilApp.swift
//  VolUtil
//
//  Created by SunnyFlops on 14/07/2025.
//

import SwiftUI

@main
struct VolUtilApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
//        Window("About", id: "about") {
//            AboutView()
//        }.defaultSize(width: 375, height: 500)
        
        Settings {
            ContentView()
        }
    }
}

