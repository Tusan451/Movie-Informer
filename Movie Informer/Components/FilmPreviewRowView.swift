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
    let title: String?
    let titleEn: String?
    let length: String?
    let countries: [FilmCountry]
    let genres: [Genre]
    let year: String
    let rating: String?
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
                    CacheAsyncImage(url: imageUrl) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 70, height: 105)
                                .cornerRadius(4, corners: .allCorners)
                        case .failure(let error):
                            // Добавить ErrorView
                            Text("Error: \(error.localizedDescription)")
                        case .empty:
                            ZStack {
                                Color("Tertiary Accent")
                                ProgressView()
                                    .tint(Color("Primary Accent"))
                            }
                        @unknown default:
                            fatalError()
                        }
                    }
                    .frame(width: 70, height: 105)
                    .cornerRadius(4, corners: .allCorners)
                    
                    VStack(spacing: 5) {
                        
                        if let title = title {
                            Text(title)
                                .font(.custom("Inter-SemiBold", size: 15))
                                .foregroundColor(Color("Text Main"))
                                .frame(width: 160, alignment: .topLeading)
                                .multilineTextAlignment(.leading)
                        }
                        
                        VStack(spacing: 2) {
                            Text("\(enTitleAndYear())")
                                .font(.custom("Inter-Regular", size: 12))
                                .foregroundColor(Color("Text Main"))
                                .frame(width: 160, alignment: .leading)
                                .multilineTextAlignment(.leading)
                            
                            if let _ = length {
                                Text(convertLength())
                                    .font(.custom("Inter-Regular", size: 12))
                                    .foregroundColor(Color("Text Main"))
                                    .frame(width: 160, alignment: .leading)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                        
                        Text(setCountryAndGenres())
                            .font(.custom("Inter-Medium", size: 12))
                            .foregroundColor(Color("Text Secondary"))
                            .frame(width: 160, alignment: .leading)
                            .multilineTextAlignment(.leading)
                        
                    }
                    .frame(width: 160, height: 105, alignment: .topLeading)
                }
                
                VStack(spacing: 4) {
                    
                    if let rating = rating, votesCount != 0 {
                        Text(rating)
                            .font(.custom("Inter-Semibold", size: 16))
                            .foregroundColor(setColorForRating())
                            .frame(width: 60, alignment: .trailing)
                        
                        Text("\(votesCount)")
                            .font(.custom("Inter-Regular", size: 12))
                            .foregroundColor(Color("Red Accent"))
                            .frame(width: 60, alignment: .trailing)
                    } else if let rating = rating, votesCount == 0 {
                        Text(rating)
                            .font(.custom("Inter-Semibold", size: 16))
                            .foregroundColor(setColorForRating())
                            .frame(width: 60, alignment: .trailing)
                    } else if rating == nil && votesCount == 0 {
                        Text(" ")
                            .font(.custom("Inter-Regular", size: 12))
                            .foregroundColor(Color("Red Accent"))
                            .frame(width: 60, alignment: .trailing)
                    } else {
                        Text("\(votesCount)")
                            .font(.custom("Inter-Regular", size: 12))
                            .foregroundColor(Color("Red Accent"))
                            .frame(width: 60, alignment: .trailing)
                    }
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
            countries: [FilmCountry(country: "США")],
            genres: [Genre(genre: "драма"), Genre(genre: "криминал"), Genre(genre: "приключения")],
            year: "1999",
            rating: "6.1",
            votesCount: 456789
        )
    }
}


extension FilmPreviewRowView {
    
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
    
    private func setColorForRating() -> Color {
        guard let rating = rating else { return Color("Back Main") }
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
    
    private func convertLength() -> String {
        guard let length = length else { return "" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        guard let date = dateFormatter.date(from: length) else { return length }
        
        let calendar = Calendar.current
        let minutes = calendar.component(.minute, from: date)
        let hours = calendar.component(.hour, from: date)
        
        return "\(hours * 60 + minutes) мин."
    }
}
