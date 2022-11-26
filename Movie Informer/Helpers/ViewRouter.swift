//
//  ViewRouter.swift
//  Movie Informer
//
//  Created by Olegio on 07.11.2022.
//

import SwiftUI

class ViewRouter: ObservableObject {
    @Published var currentPage: Page = .home
}


enum Page {
    case home
    case search
    case bookmarks
    case viewed
    case settings
}
