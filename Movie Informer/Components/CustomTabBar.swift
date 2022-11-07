//
//  CustomTabBar.swift
//  Movie Informer
//
//  Created by Olegio on 07.11.2022.
//

import SwiftUI

struct CustomTabBar: View {
    @StateObject var viewRouter: ViewRouter
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/12)
                .cornerRadius(40, corners: [.topLeft, .topRight])
                .foregroundColor(Color("Primary Accent"))
            
            HStack(spacing: UIScreen.main.bounds.width/8) {
                CustomTabBarItem(
                    viewRouter: viewRouter,
                    assignedPage: .home,
                    imageName: "Home",
                    color: .white
                )
                CustomTabBarItem(
                    viewRouter: viewRouter,
                    assignedPage: .bookmarks,
                    imageName: "Bookmarks",
                    color: .white
                )
                CustomTabBarItem(
                    viewRouter: viewRouter,
                    assignedPage: .viewed,
                    imageName: "Viewed",
                    color: .white
                )
                CustomTabBarItem(
                    viewRouter: viewRouter,
                    assignedPage: .settings,
                    imageName: "Settings",
                    color: .white
                )
            }
            .frame(width: UIScreen.main.bounds.width - 50, height: UIScreen.main.bounds.height/12)
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(viewRouter: ViewRouter())
    }
}
