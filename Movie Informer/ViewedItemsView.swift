//
//  ViewedItemsView.swift
//  Movie Informer
//
//  Created by Olegio on 29.11.2022.
//

import SwiftUI
import RealmSwift

struct ViewedItemsView: View {
    @ObservedResults(SavedItem.self) var savedItems
    @State private var viewedItems = [SavedItem]()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Back Main")
                    .ignoresSafeArea()
                
                if viewedItems.isEmpty {
                    PlaceholderView(
                        image: "eye",
                        imageWidth: 90,
                        imageHeight: 55,
                        color: Color("Primary Accent"),
                        title: "У вас нет просмотренных фильмов",
                        message: "Здесь будут отображаться фильмы, отмеченные как просмотренные"
                    )
                } else {
                    ScrollView {
                        VStack(spacing: 32) {
                            Text("Фильмов просмотрено: \(viewedItems.count)")
                                .font(.custom("Inter-SemiBold", size: 12))
                                .foregroundColor(Color("Text Secondary"))
                                .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
                            
                            LazyVStack(spacing: 20) {
                                ForEach(Array(viewedItems.enumerated()), id: \.offset) { (index, item) in
                                    NavigationLink(destination: FilmInfoView(
                                        collectionName: item.collectionName,
                                        savedItem: item
                                    )) {
                                        ActorFilmView(
                                            image: item.posterUrl,
                                            title: item.nameRu,
                                            enTitle: item.nameOriginal,
                                            year: item.year,
                                            length: item.filmLength,
                                            countries: addCountriesTo(item),
                                            genres: addGenresTo(item),
                                            rating: setRatingFor(item),
                                            viewedButton: RoundedButtonView(
                                                width: 32,
                                                height: 32,
                                                buttonColor: Color("Primary Accent"),
                                                iconColor: .white,
                                                iconName: "ViewSmall",
                                                action: {
                                                    viewedItems.remove(at: index)
                                                    editItem(item, value: false)
                                                }
                                            )
                                        )
                                    }
                                }
                            }
                        }
                        
                        Rectangle()
                            .foregroundColor(Color("Back Main"))
                            .frame(width: UIScreen.main.bounds.width, height: 60)
                    }
                }
            }
            .navigationTitle("Просмотрено")
            .onAppear() {
                filterItems()
            }
        }
        .tint(Color("Secondary Accent"))
    }
}

struct ViewedItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ViewedItemsView()
    }
}


extension ViewedItemsView {
    
    private func filterItems() {
        viewedItems = savedItems.filter { $0.inViewed }
        print("Viewed items contains:", viewedItems)
    }
    
    private func addCountriesTo(_ item: SavedItem) -> [FilmCountry] {
        var countries: [FilmCountry] = []
        
        for country in item.countries {
            let filmCountry = FilmCountry(country: country.countryName)
            countries.append(filmCountry)
        }
        
        return countries
    }
    
    private func addGenresTo(_ item: SavedItem) -> [Genre] {
        var genres: [Genre] = []
        
        for genre in item.genres {
            let filmGenre = Genre(genre: genre.genreName)
            genres.append(filmGenre)
        }
        
        return genres
    }
    
    private func setRatingFor(_ item: SavedItem) -> String? {
        if let rating = item.filmRating {
            return String(rating)
        } else if let ratingAwait = item.ratingAwait {
            return String(ratingAwait) + "%"
        } else {
            return nil
        }
    }
    
    private func editItem(_ item: SavedItem, value: Bool) {
        
        if item.inBookmarks {
            if let newItem = item.thaw(),
               let realm = newItem.realm {
                try? realm.write {
                    newItem.inViewed = value
                }
            }
        } else {
            if let newItem = item.thaw(),
                let realm = newItem.realm {
                try? realm.write {
                    realm.delete(newItem.countries)
                    realm.delete(newItem.genres)
                    realm.delete(newItem)
                }
            }
        }
    }
}
