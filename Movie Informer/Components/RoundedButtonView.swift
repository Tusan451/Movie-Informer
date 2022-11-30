//
//  RoundedButtonView.swift
//  Movie Informer
//
//  Created by Olegio on 28.11.2022.
//

import SwiftUI

struct RoundedButtonView: View {
    let width: CGFloat
    let height: CGFloat
    let buttonColor: Color
    let iconColor: Color
    let iconName: String
    let action: () -> Void
    
    var body: some View {
//        ZStack {
//            Circle()
//                .foregroundColor(buttonColor)
//                .frame(width: width, height: height)
//
//            Image(iconName)
//                .resizable()
//                .renderingMode(.template)
//                .foregroundColor(iconColor)
//                .frame(width: width / 2.2, height: height / 2.2)
//        }
        Button(action: action) {
            ZStack {
                Circle()
                    .foregroundColor(buttonColor)
                    .frame(width: width, height: height)
                
                Image(iconName)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(iconColor)
                    .frame(width: width / 2.2, height: height / 2.2)
            }
        }
    }
}

struct RoundedButtonView_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButtonView(
            width: 32,
            height: 32,
            buttonColor: Color("Back Secondary"),
            iconColor: Color("Text Main"),
            iconName: "BookmarkSmall") {
                ///
            }
    }
}
