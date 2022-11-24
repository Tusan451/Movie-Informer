//
//  RatingViewSmall.swift
//  Movie Informer
//
//  Created by Olegio on 23.11.2022.
//

import SwiftUI

struct RatingViewSmall: View {
    let rating: String?
    
    var body: some View {
        ZStack {
            if let rating = rating, rating.count <= 3 {
                Rectangle()
                    .frame(width: 28, height: 22)
                    .cornerRadius(4, corners: .allCorners)
                    .foregroundColor(setBackColor())
                
                Text(setRating())
                    .frame(width: 28, height: 22, alignment: .center)
                    .foregroundColor(.white)
                    .font(.custom("Inter-Bold", size: 12))
            } else {
                Rectangle()
                    .frame(width: 48, height: 22)
                    .cornerRadius(6, corners: .allCorners)
                    .foregroundColor(setBackColor())
                
                Text(setRating())
                    .frame(width: 48, height: 22, alignment: .center)
                    .foregroundColor(.white)
                    .font(.custom("Inter-Bold", size: 12))
            }
        }
    }
    
    private func setRating() -> String {
        guard let rating = rating else { return "" }
        return rating
    }
    
    private func setBackColor() -> Color {
        switch rating?.first {
        case "9":
            return Color("Primary Accent")
        case "7", "8":
            return Color("Green Accent")
        default:
            return Color("Text Secondary")
        }
    }
}

struct RatingViewSmall_Previews: PreviewProvider {
    static var previews: some View {
        RatingViewSmall(rating: "9.6")
    }
}
