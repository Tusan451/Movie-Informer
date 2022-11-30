//
//  BookmarksView.swift
//  Movie Informer
//
//  Created by Olegio on 28.11.2022.
//

import SwiftUI
import RealmSwift

struct BookmarksView: View {
    @ObservedResults(SavedItem.self) var savedItems
    @State private var bookmarks = [SavedItem]()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Back Main")
                    .ignoresSafeArea()
                
                if bookmarks.isEmpty {
                    PlaceholderView(
                        image: "books.vertical.fill",
                        imageWidth: 90,
                        imageHeight: 70,
                        color: Color("Red Accent"),
                        title: "У вас нет сохраненных фильмов",
                        message: "Здесь будут отображаться фильмы, добавленные вами в закладки"
                    )
                } else {
                    ScrollView {
                        VStack(spacing: 32) {
                            Text("Фильмов добавлено: \(bookmarks.count)")
                                .font(.custom("Inter-SemiBold", size: 12))
                                .foregroundColor(Color("Text Secondary"))
                                .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
                            
                            LazyVStack(spacing: 20) {
                                ForEach(Array(bookmarks.enumerated()), id: \.offset) { (index, bookmark) in
                                    NavigationLink(destination: FilmInfoView(
                                        collectionName: bookmark.collectionName,
                                        savedItem: bookmark
                                    )) {
                                        ActorFilmView(
                                            image: bookmark.posterUrl,
                                            title: bookmark.nameRu,
                                            enTitle: bookmark.nameOriginal,
                                            year: bookmark.year,
                                            length: bookmark.filmLength,
                                            countries: addCountriesTo(bookmark),
                                            genres: addGenresTo(bookmark),
                                            rating: setRatingFor(bookmark),
                                            bookmarkButton: RoundedButtonView(
                                                width: 32,
                                                height: 32,
                                                buttonColor: Color("Red Accent"),
                                                iconColor: .white,
                                                iconName: "BookmarkSmall",
                                                action: {
                                                    bookmarks.remove(at: index)
                                                    editItem(bookmark, value: false)
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
            .navigationTitle("Закладки")
            .onAppear() {
                filterBookmarks()
            }
        }
        .tint(Color("Secondary Accent"))
    }
}

struct BookmarksView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarksView()
    }
}


extension BookmarksView {
    private func setRatingFor(_ bookmarkFilm: SavedItem) -> String? {
        if let rating = bookmarkFilm.filmRating {
            return String(rating)
        } else if let ratingAwait = bookmarkFilm.ratingAwait {
            return String(ratingAwait) + "%"
        } else {
            return nil
        }
    }
    
    private func addCountriesTo(_ bookmark: SavedItem) -> [FilmCountry] {
        var countries: [FilmCountry] = []
        
        for country in bookmark.countries {
            let filmCountry = FilmCountry(country: country.countryName)
            countries.append(filmCountry)
        }
        
        return countries
    }
    
    private func addGenresTo(_ bookmark: SavedItem) -> [Genre] {
        var genres: [Genre] = []
        
        for genre in bookmark.genres {
            let filmGenre = Genre(genre: genre.genreName)
            genres.append(filmGenre)
        }
        
        return genres
    }
    
//    private func setRatingFor(_ film: FilmInfoById) -> String? {
//        if let ratingKinopoisk = film.ratingKinopoisk {
//            return String(ratingKinopoisk)
//        } else if let ratingAwait = film.ratingAwait {
//            return String(ratingAwait) + "%"
//        } else {
//            return nil
//        }
//    }
    
    private func filterBookmarks() {
        bookmarks = savedItems.filter { $0.inBookmarks }
        print("Bookmarks contains:", bookmarks)
    }
    
    private func editItem(_ item: SavedItem, value: Bool) {
        
        if item.inViewed {
            if let newItem = item.thaw(),
               let realm = newItem.realm {
                try? realm.write {
                    newItem.inBookmarks = value
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
