//
//  CustomTabBarItem.swift
//  Movie Informer
//
//  Created by Olegio on 07.11.2022.
//

import SwiftUI

struct CustomTabBarItem: View {
    @StateObject var viewRouter: ViewRouter
    let assignedPage: Page
    let imageName: String
    let color: Color
    
    var body: some View {
        Image(imageName)
            .renderingMode(.template)
            .resizable()
            .foregroundColor(
                viewRouter.currentPage == assignedPage ? .white : Color("Secondary Accent")
            )
            .frame(width: 40, height: 40)
            .onTapGesture {
                viewRouter.currentPage = assignedPage
            }
    }
}

struct CustomTabBarItem_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("Primary Accent")
            CustomTabBarItem(viewRouter: ViewRouter(), assignedPage: .home, imageName: "Home", color: .white)
        }
    }
}
