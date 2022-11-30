//
//  ActorFilmView.swift
//  Movie Informer
//
//  Created by Olegio on 23.11.2022.
//

import SwiftUI

struct ActorFilmView: View {
    let image: String
    let title: String?
    let enTitle: String?
    let year: Int
    let length: Int?
    let countries: [FilmCountry]
    let genres: [Genre]
    let rating: String?
    var bookmarkButton: RoundedButtonView? = nil
    var viewedButton: RoundedButtonView? = nil
    
    var body: some View {
        HStack(spacing: 24) {
            ZStack {
                if let url = URL(string: image) {
                    CacheAsyncImage(url: url) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 90, height: 140)
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
                    .frame(width: 90, height: 140)
                    .cornerRadius(4, corners: .allCorners)
                    
                } else {
                    // Добавить ErrorView
                    Text("Error")
                }
                
                if let rating = rating {
                    if let rating = rating {
                        RatingViewSmall(rating: rating)
                            .offset(x: -7, y: 7)
                            .frame(width: 90, height: 140, alignment: .topTrailing)
                    } else {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 90, height: 140, alignment: .topTrailing)
                    }
                }
            }
            
            VStack(spacing: 12) {
                
                VStack(spacing: 8) {
                    
                    if let title = title {
                        Text(title)
                            .font(.custom("Inter-SemiBold", size: 15))
                            .foregroundColor(Color("Text Main"))
                            .frame(width: UIScreen.main.bounds.width / 1.7, alignment: .topLeading)
                            .multilineTextAlignment(.leading)
                    }
                    
                    VStack(spacing: 4) {
                        Text(enTitleAndYear())
                            .font(.custom("Inter-Regular", size: 12))
                            .foregroundColor(Color("Text Main"))
                            .frame(width: UIScreen.main.bounds.width / 1.7, alignment: .leading)
                            .multilineTextAlignment(.leading)
                        
                        if let length = length {
                            Text("\(length) мин.")
                                .font(.custom("Inter-Regular", size: 12))
                                .foregroundColor(Color("Text Main"))
                                .frame(width: UIScreen.main.bounds.width / 1.7, alignment: .leading)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    
                    Text(setCountryAndGenres())
                        .font(.custom("Inter-Medium", size: 12))
                        .foregroundColor(Color("Text Secondary"))
                        .frame(width: UIScreen.main.bounds.width / 1.7, alignment: .leading)
                        .multilineTextAlignment(.leading)
                }
                .frame(width: UIScreen.main.bounds.width / 1.7, height: 90, alignment: .topLeading)
                
                HStack(spacing: 8) {
                    if let bookmarkButton = bookmarkButton {
                        RoundedButtonView(
                            width: bookmarkButton.width,
                            height: bookmarkButton.height,
                            buttonColor: bookmarkButton.buttonColor,
                            iconColor: bookmarkButton.iconColor,
                            iconName: bookmarkButton.iconName,
                            action: bookmarkButton.action
                        )
                    }
                    if let viewedButton = viewedButton {
                        RoundedButtonView(
                            width: viewedButton.width,
                            height: viewedButton.height,
                            buttonColor: viewedButton.buttonColor,
                            iconColor: viewedButton.iconColor,
                            iconName: viewedButton.iconName,
                            action: viewedButton.action
                        )
                    }
                }
                .frame(width: UIScreen.main.bounds.width / 1.7, alignment: .leading)
            }
        }
    }
}

struct ActorFilmView_Previews: PreviewProvider {
    static var previews: some View {
        ActorFilmView(
            image: "https://kinopoiskapiunofficial.tech/images/posters/kp/435.jpg",
            title: "Зеленая миля",
            enTitle: "The Green Mile",
            year: 1999,
            length: 189,
            countries: [FilmCountry(country: "США")],
            genres: [Genre(genre: "драма"), Genre(genre: "криминал"), Genre(genre: "приключения")],
            rating: "9.1",
            bookmarkButton: RoundedButtonView(
                width: 32,
                height: 32,
                buttonColor: Color("Red Accent"),
                iconColor: .white,
                iconName: "BookmarkSmall",
                action: {
                    ///
                }
            )
        )
    }
}


extension ActorFilmView {
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
        
        if let enTitle = enTitle {
            text = "\(enTitle), \(year) г."
        } else {
            text = "\(year) г."
        }
        
        return text
    }
}
