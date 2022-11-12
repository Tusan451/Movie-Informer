//
//  LoadMoreButton.swift
//  Movie Informer
//
//  Created by Olegio on 11.11.2022.
//

import SwiftUI

struct LoadMoreButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 140, height: 36)
                .cornerRadius(30, corners: .allCorners)
                .foregroundColor(Color("Back Secondary"))
            
            Button(title, action: action)
                .frame(width: 140, height: 36)
                .font(.custom("Inter-Medium", size: 13))
            .foregroundColor(Color("Text Main"))
        }
    }
}

struct LoadMoreButton_Previews: PreviewProvider {
    static var previews: some View {
        LoadMoreButton(title: "Показать больше") {
            ///
        }
    }
}
