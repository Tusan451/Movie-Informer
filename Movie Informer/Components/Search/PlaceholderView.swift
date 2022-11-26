//
//  PlaceholderView.swift
//  Movie Informer
//
//  Created by Olegio on 25.11.2022.
//

import SwiftUI

struct PlaceholderView: View {
    let image: String
    let color: Color
    let title: String
    let message: String
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: image)
                .renderingMode(.template)
                .resizable()
                .foregroundColor(color)
                .frame(width: 90, height: 70)
            
            VStack(spacing: 6) {
                Text(title)
                    .font(.custom("Inter-SemiBold", size: 20))
                    .foregroundColor(Color("Text Main"))
                    .multilineTextAlignment(.center)
                    .frame(width: 230, alignment: .center)
                
                Text(message)
                    .font(.custom("Inter-SemiBold", size: 15))
                    .foregroundColor(Color("Text Secondary"))
                    .multilineTextAlignment(.center)
                    .frame(width: 230, alignment: .center)
            }
        }
    }
}

struct PlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderView(
            image: "sparkles.tv.fill",
            color: Color("Red Accent"),
            title: "Начните искать",
            message: "Подробная информация о любимом актере"
        )
    }
}
