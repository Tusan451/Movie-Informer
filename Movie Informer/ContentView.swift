//
//  ContentView.swift
//  Movie Informer
//
//  Created by Olegio on 03.11.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack {
            Spacer()
            switch viewRouter.currentPage {
            case .home:
                HomeView()
            case .bookmarks:
                Text("Bookmarks View")
            case .viewed:
                Text("Viewed View")
            case .settings:
                Text("Settings View")
            }
            Spacer()
            CustomTabBar(viewRouter: viewRouter)
        }
            .edgesIgnoringSafeArea(.bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewRouter: ViewRouter())
    }
}
