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
        ZStack {
            switch viewRouter.currentPage {
            case .home:
                HomeView()
            case .search:
                SearchCategories()
            case .bookmarks:
                BookmarksView()
            case .viewed:
                ViewedItemsView()
            case .settings:
                SettingsView()
            }
            VStack {
                Spacer()
                CustomTabBar(viewRouter: viewRouter)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewRouter: ViewRouter())
    }
}
