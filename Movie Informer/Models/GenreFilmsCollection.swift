//
//  GenreFilmsCollection.swift
//  Movie Informer
//
//  Created by Olegio on 15.11.2022.
//

import Foundation

// Model for genre films collections
struct GenreFilmsCollection: Codable {
    var totalPages: Int
    var items: [GenreFilmData]
}

struct GenreFilmData: Codable {
    var kinopoiskId: Int
    var nameRu: String
    var nameOriginal: String
    var countries: [CountryGenre]
    var genres: [GenreGenre]
    var ratingKinopoisk: Int
    var year: Int
    var posterUrl: String
}

struct CountryGenre: Codable {
    var country: String
}

struct GenreGenre: Codable {
    var genre: String
}
