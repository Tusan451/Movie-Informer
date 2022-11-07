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
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewRouter: viewRouter)
        }
    }
}
