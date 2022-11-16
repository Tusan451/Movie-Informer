//
//  FilmSecondPreviewRowView.swift
//  Movie Informer
//
//  Created by Olegio on 15.11.2022.
//

import SwiftUI

struct FilmSecondPreviewRowView: View {
    let image: String
    let position: Int
    let title: String
    let titleEn: String?
    let countries: [FilmCountry]
    let genres: [Genre]
    let year: Int
    let rating: Double
    
    var genresText = ""
    
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
                            Text("\(enTitleAndYear())")
                                .font(.custom("Inter-Regular", size: 12))
                                .foregroundColor(Color("Text Main"))
                                .frame(width: 160, alignment: .leading)
                                .multilineTextAlignment(.leading)
                        }
                        
                        Text(setCountryAndGenres())
                            .font(.custom("Inter-Medium", size: 12))
                            .foregroundColor(Color("Text Secondary"))
                            .frame(width: 160, alignment: .leading)
                            .multilineTextAlignment(.leading)
                        
                    }
                    .frame(width: 160, height: 105, alignment: .topLeading)
                }
                
                Text(setRatingText())
                    .font(.custom("Inter-Semibold", size: 16))
                    .foregroundColor(setColorForRating())
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

struct FilmSecondPreviewRowView_Previews: PreviewProvider {
    static var previews: some View {
        FilmSecondPreviewRowView(
            image: "https://kinopoiskapiunofficial.tech/images/posters/kp/435.jpg",
            position: 1,
            title: "Зеленая миля",
            titleEn: "The Green Mile",
            countries: [FilmCountry(country: "США")],
            genres: [Genre(genre: "драма"), Genre(genre: "криминал"), Genre(genre: "приключения")],
            year: 1999,
            rating: 9.1
        )
    }
}


extension FilmSecondPreviewRowView {
    
    private func setCountryAndGenres() -> String {
        var text = ""
        
        for country in countries {
            text += country.country + ", "
        }
        
        for genre in genres {
            text += genre.genre + ", "
        }
        
        text.removeLast()
        text.removeLast()
        
        return text
    }
    
    private func enTitleAndYear() -> String {
        var text = ""
        
        if let titleEn = titleEn {
            text = "\(titleEn), \(year) г."
        } else {
            text = "\(year) г."
        }
        
        return text
    }
    
    private func setRatingText() -> String {
        return String(rating)
    }
    
    private func setColorForRating() -> Color {
        let rating = setRatingText()
        var color: Color
        
        switch rating.first {
        case "9":
            color = Color("Secondary Accent")
        case "7", "8":
            color = Color("Green Accent")
        default:
            color = Color("Text Secondary")
        }
        
        return color
    }
}
