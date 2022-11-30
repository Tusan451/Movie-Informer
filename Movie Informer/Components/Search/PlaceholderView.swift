//
//  PlaceholderView.swift
//  Movie Informer
//
//  Created by Olegio on 25.11.2022.
//

import SwiftUI

struct PlaceholderView: View {
    let image: String
    let imageWidth: CGFloat
    let imageHeight: CGFloat
    let color: Color
    let title: String
    let message: String
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: image)
                .renderingMode(.template)
                .resizable()
                .foregroundColor(color)
                .frame(width: imageWidth, height: imageHeight)
            
            VStack(spacing: 6) {
                Text(title)
                    .font(.custom("Inter-SemiBold", size: 20))
                    .foregroundColor(Color("Text Main"))
                    .multilineTextAlignment(.center)
                    .frame(width: UIScreen.main.bounds.width - 120, alignment: .center)
                
                Text(message)
                    .font(.custom("Inter-SemiBold", size: 14))
                    .foregroundColor(Color("Text Secondary"))
                    .multilineTextAlignment(.center)
                    .frame(width: UIScreen.main.bounds.width - 120, alignment: .center)
            }
        }
    }
}

struct PlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderView(
            image: "sparkles.tv.fill",
            imageWidth: 90,
            imageHeight: 70,
            color: Color("Red Accent"),
            title: "Начните искать dldfmslms lmslscms lmcsmlsm",
            message: "Подробная информация о любимом актере"
        )
    }
}
