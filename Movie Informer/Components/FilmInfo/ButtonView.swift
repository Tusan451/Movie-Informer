//
//  ButtonView.swift
//  Movie Informer
//
//  Created by Olegio on 15.11.2022.
//

import SwiftUI

struct ButtonView: View {
    let width: CGFloat
    let height: CGFloat
    let buttonColor: Color
    let iconColor: Color
    let textColor: Color
    let text: String
    let iconName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(iconName)
                    .renderingMode(.template)
                    .resizable()
                    .foregroundColor(iconColor)
                    .frame(width: 16, height: 16)
                
                Text(text)
                    .font(.custom("Inter-Medium", size: 12))
                    .foregroundColor(textColor)
            }
            .frame(width: width, height: height)
        }
        .background(buttonColor)
        .cornerRadius(width / 2, corners: .allCorners)
        .frame(width: width, height: height)
    }
}

struct SmallButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(
            width: 100,
            height: 34,
            buttonColor: Color("Red Accent"),
            iconColor: .white,
            textColor: .white,
            text: "Трейлер",
            iconName: "Play") {
                ///
            }
    }
}
