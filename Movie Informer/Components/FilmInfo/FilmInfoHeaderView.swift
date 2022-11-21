//
//  FilmInfoHeaderView.swift
//  Movie Informer
//
//  Created by Olegio on 15.11.2022.
//

import SwiftUI

struct FilmInfoHeaderView: View {
    let image: String
    let rating: String?
    let filmTitleRu: String
    let filmTitleEn: String?
    let year: String
    let length: String?
    let countries: [FilmCountry]
    let genres: [Genre]
    let ageLimit: String?
    
    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                AsyncImage(url: URL(string: image)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
                } placeholder: {
                    ZStack {
                        Color("Tertiary Accent")
                        ProgressView()
                            .tint(Color("Primary Accent"))
                    }
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
                
                if let rating = rating {
                    RatingView(rating: rating)
                        .padding()
                        .offset(y: 10)
                        .frame(width: UIScreen.main.bounds.width, height: 584, alignment: .topTrailing)
                } else {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: UIScreen.main.bounds.width, height: 584, alignment: .topTrailing)
                }
            }
            
            VStack(spacing: 16) {
                VStack(spacing: 8) {
                    Text(filmTitleRu)
                        .font(.custom("Inter-Bold", size: 26))
                        .foregroundColor(Color("Text Main"))
                        .frame(width: UIScreen.main.bounds.width - 40, alignment: .center)
                        .multilineTextAlignment(.center)
                    
                    VStack(spacing: 4) {
                        Text(enTitleAndYear())
                            .font(.custom("Inter-Regular", size: 14))
                            .foregroundColor(Color("Text Main"))
                            .frame(width: UIScreen.main.bounds.width - 40, alignment: .center)
                            .multilineTextAlignment(.center)
                        
                        if length != nil {
                            Text(convertLength())
                                .font(.custom("Inter-Regular", size: 14))
                                .foregroundColor(Color("Text Main"))
                                .frame(width: UIScreen.main.bounds.width - 40, alignment: .center)
                                .multilineTextAlignment(.center)
                        }
                    }
                    
                    Text(setCountryAndGenres())
                        .font(.custom("Inter-Medium", size: 14))
                        .foregroundColor(Color("Text Secondary"))
                        .frame(width: UIScreen.main.bounds.width - 40, alignment: .center)
                        .multilineTextAlignment(.center)
                    
                    if let ageLimit = ageLimit {
                        AgeLimitView(ageLimit: ageLimit)
                    }
                }
            }
        }
    }
}

struct FilmInfoHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            FilmInfoHeaderView(
                image: "https://kinopoiskapiunofficial.tech/images/posters/kp/435.jpg",
                rating: "9.1",
                filmTitleRu: "Зеленая миля",
                filmTitleEn: "The Green Mile",
                year: "1999",
                length: "189",
                countries: [FilmCountry(country: "США")],
                genres: [Genre(genre: "драма"), Genre(genre: "криминал")],
                ageLimit: "16+"
            )
        }
    }
}

extension FilmInfoHeaderView {
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
        
        if let filmTitleEn = filmTitleEn {
            text = "\(filmTitleEn), \(year) г."
        } else {
            text = "\(year) г."
        }
        
        return text
    }
    
    private func convertLength() -> String {
        guard let length = length else { return "" }
        
        if length.count <= 3 {
            return length + " мин."
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        guard let date = dateFormatter.date(from: length) else { return length }
        
        let calendar = Calendar.current
        let minutes = calendar.component(.minute, from: date)
        let hours = calendar.component(.hour, from: date)
        
        return "\(hours * 60 + minutes) мин."
    }
}
