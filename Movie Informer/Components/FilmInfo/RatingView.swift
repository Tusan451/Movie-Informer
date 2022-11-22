//
//  RatingView.swift
//  Movie Informer
//
//  Created by Olegio on 15.11.2022.
//

import SwiftUI

struct RatingView: View {
    let rating: String?
    
    var body: some View {
        ZStack {
            if let rating = rating, rating.count <= 3 {
                Rectangle()
                    .frame(width: 51, height: 40)
                    .cornerRadius(6, corners: .allCorners)
                    .foregroundColor(setBackColor())
                
                Text(setRating())
                    .frame(width: 51, height: 40, alignment: .center)
                    .foregroundColor(.white)
                    .font(.custom("Inter-SemiBold", size: 20))
            } else {
                Rectangle()
                    .frame(width: 90, height: 40)
                    .cornerRadius(6, corners: .allCorners)
                    .foregroundColor(setBackColor())
                
                Text(setRating())
                    .frame(width: 90, height: 40, alignment: .center)
                    .foregroundColor(.white)
                    .font(.custom("Inter-SemiBold", size: 20))
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

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: "9.1")
    }
}
