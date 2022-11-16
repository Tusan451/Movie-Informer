//
//  FilmResponce.swift
//  Movie Informer
//
//  Created by Olegio on 09.11.2022.
//

import Foundation

// Model for top films collections
struct FilmResponce: Codable {
    var pagesCount: Int
    var films: [FilmBaseData]
}

struct FilmBaseData: Codable {
    var filmId: Int
    var nameRu: String
    var nameEn: String?
    var year: String
    var filmLength: String
    var countries: [FilmCountry]
    var genres: [Genre]
    var rating: String?
    var ratingVoteCount: Int
    var posterUrl: String
}

struct FilmCountry: Codable {
    var country: String
}

struct Genre: Codable {
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

// Model for trailers
struct FilmTrailers: Codable {
    var items: [FilmTrailer]
}

struct FilmTrailer: Codable {
    var url: String
    var name: String
    var site: String
}
