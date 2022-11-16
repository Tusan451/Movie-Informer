//
//  ServerModels.swift
//  Movie Informer
//
//  Created by Olegio on 15.11.2022.
//

import Foundation

// Model for top films collections
struct TopFilmsCollection: Codable {
    var pagesCount: Int
    var films: [TopFilmData]
}

struct TopFilmData: Codable {
    var filmId: Int
    var nameRu: String
    var nameEn: String?
    var year: String
    var filmLength: String
    var countries: [CountryTop]
    var genres: [GenrTop]
    var rating: String?
    var ratingVoteCount: Int
    var posterUrl: String
}

struct CountryTop: Codable {
    var country: String
}

struct GenrTop: Codable {
    var genre: String
}

// Model for genre films collections
struct GenreFilmsCollection: Codable {
    var totalPages: Int
    var items: [GenreFilmData]
}

struct GenreFilmData: Codable {
    var kinopoiskId: Int
    var nameRu: String?
    var nameOriginal: String?
    var countries: [FilmCountry]
    var genres: [Genre]
    var ratingKinopoisk: Double
    var year: Int
    var posterUrl: String
}

struct CountryGenre: Codable {
    var country: String
}

struct GenreGenre: Codable {
    var genre: String
}
