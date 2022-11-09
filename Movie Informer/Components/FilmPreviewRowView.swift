//
//  FilmPreviewRowView.swift
//  Movie Informer
//
//  Created by Olegio on 08.11.2022.
//

import SwiftUI

struct FilmPreviewRowView: View {
    let image: String
    let position: Int
    let title: String
    let titleEn: String
    let length: String
    let genre: String
    let year: String
    let rating: String
    let votesCount: Int
    
    var imageUrl: URL {
        return URL(string: image)!
    }
    
    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Text("\(position)")
                    .font(.custom("Inter-Semibold", size: 14))
                    .foregroundColor(Color("Text Main"))
                    .frame(width: 30, height: 105, alignment: .topLeading)
                
                HStack(spacing: 12) {
                    AsyncImage(url: imageUrl) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 70, height: 105)
                            .cornerRadius(4, corners: .allCorners)
                    } placeholder: {
                        ZStack {
                            Color("Tertiary Accent")
                            ProgressView()
                                .tint(Color("Primary Accent"))
                        }
                    }
                    .frame(width: 70, height: 105)
                    .cornerRadius(4, corners: .allCorners)
                    
                    VStack(spacing: 5) {
                        Text(title)
                            .font(.custom("Inter-SemiBold", size: 15))
                            .foregroundColor(Color("Text Main"))
                            .frame(width: 160, alignment: .topLeading)
                            .multilineTextAlignment(.leading)
                        
                        VStack(spacing: 2) {
                            Text("\(titleEn), \(year) г.")
                                .font(.custom("Inter-Regular", size: 12))
                                .foregroundColor(Color("Text Main"))
                                .frame(width: 160, alignment: .leading)
                                .multilineTextAlignment(.leading)
                            
                            Text(length)
                                .font(.custom("Inter-Regular", size: 12))
                                .foregroundColor(Color("Text Main"))
                                .frame(width: 160, alignment: .leading)
                                .multilineTextAlignment(.leading)
                        }
                        
                        Text(genre)
                            .font(.custom("Inter-Medium", size: 12))
                            .foregroundColor(Color("Text Secondary"))
                            .frame(width: 160, alignment: .leading)
                            .multilineTextAlignment(.leading)
                    }
                    .frame(width: 160, height: 105, alignment: .topLeading)
                }
                
                VStack(spacing: 4) {
                    Text(rating)
                        .font(.custom("Inter-Semibold", size: 16))
                        .foregroundColor(Color("Green Accent"))
                        .frame(width: 60, alignment: .trailing)
                    
                    Text("\(votesCount)")
                        .font(.custom("Inter-Regular", size: 12))
                        .foregroundColor(Color("Red Accent"))
                        .frame(width: 60, alignment: .trailing)
                }
                .frame(width: 60, height: 105, alignment: .topTrailing)
            }
            .frame(width: UIScreen.main.bounds.width - 40, alignment: .topLeading)
            
            Divider()
                .overlay(Color("Back Secondary"))
                .frame(width: UIScreen.main.bounds.width - 40)
        }
        .frame(width: UIScreen.main.bounds.width, height: 150, alignment: .bottom)
    }
}

struct FilmPreviewRowView_Previews: PreviewProvider {
    static var previews: some View {
        FilmPreviewRowView(
            image: "https://kinopoiskapiunofficial.tech/images/posters/kp/435.jpg",
            position: 1,
            title: "Зеленая миля",
            titleEn: "The Green Mile",
            length: "03:09",
            genre: "драма, криминал",
            year: "1999",
            rating: "9.1",
            votesCount: 813305
        )
    }
}
