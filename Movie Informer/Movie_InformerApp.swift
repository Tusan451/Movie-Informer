//
//  Movie_InformerApp.swift
//  Movie Informer
//
//  Created by Olegio on 03.11.2022.
//

import SwiftUI

@main
struct Movie_InformerApp: App {
    @StateObject var viewRouter = ViewRouter()
    @StateObject var csManager = ColorSchemeManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewRouter: viewRouter)
                .environmentObject(csManager)
                .onAppear {
                    csManager.applyColorScheme()
                }
        }
    }
}
