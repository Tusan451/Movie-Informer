//
//  FilmsCollectionCellView.swift
//  Movie Informer
//
//  Created by Olegio on 07.11.2022.
//

import SwiftUI

struct FilmsCollectionCellView: View {
    let imageName: String
    let title: String
    let filmsCount: Int
    let viewed: Int
    
    var body: some View {
        HStack(spacing: 16) {
            HStack(spacing: 16) {
                Image(imageName)
                    .resizable()
                    .frame(width: 72, height: 72)
                
                Text(title)
                    .font(.custom("Inter-SemiBold", size: 16))
                    .foregroundColor(Color("Text Main"))
                    .frame(width: 140, alignment: .leading)
                    .multilineTextAlignment(.leading)
            }
            
            HStack(spacing: 8) {
                HStack(spacing: 4) {
                    Text("\(viewed)")
                        .font(.custom("Inter-Semibold", size: 14))
                        .foregroundColor(viewed > 0 ? Color("Blue Accent") : Color("Text Secondary"))
                    Text("из \(filmsCount)")
                        .font(.custom("Inter-SemiBold", size: 14))
                        .foregroundColor(Color("Text Secondary"))
                }
                .frame(width: 80, alignment: .trailing)
                
                CircularProgressView(
                    progress: (Double(viewed) / Double(filmsCount/100)) / 100,
                    width: 20,
                    height: 20
                )
            }
            .frame(alignment: .trailing)
        }
        .frame(width: UIScreen.main.bounds.width, height: 90, alignment: .center)
        .offset(y: 9)
    }
}

struct FilmsCollectionCellView_Previews: PreviewProvider {
    static var previews: some View {
        FilmsCollectionCellView(
            imageName: "250 лучших фильмов",
            title: "250 лучших фильмов",
            filmsCount: 250,
            viewed: 250
        )
    }
}
