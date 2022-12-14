//
//  FilmResponce.swift
//  Movie Informer
//
//  Created by Olegio on 09.11.2022.
//

import Foundation

// Top films collections
struct FilmResponce: Codable {
    var pagesCount: Int
    var films: [FilmBaseData]
}

struct FilmBaseData: Codable {
    var filmId: Int
    var nameRu: String?
    var nameEn: String?
    var year: String
    var filmLength: String?
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

// Genre films collections
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

// Trailers
struct FilmTrailers: Codable {
    var items: [FilmTrailer]
}

struct FilmTrailer: Codable {
    var url: String
    var name: String
    var site: String
}

// Film Info by ID
struct FilmInfoById: Codable {
    var kinopoiskId: Int
    var nameRu: String?
    var nameOriginal: String?
    var posterUrl: String
    var ratingKinopoisk: Double?
    var ratingAwait: Double?
    var year: Int
    var filmLength: Int?
    var slogan: String?
    var description: String?
    var type: String
    var ratingAgeLimits: String?
    var countries: [FilmCountry]
    var genres: [Genre]
}

// Film Box Office
struct FilmBoxOffice: Codable {
    var items: [BoxOfficeItem]
}

struct BoxOfficeItem: Codable {
    var type: String
    var amount: Int
    var currencyCode: String
}

// Film Team
struct FilmTeamate: Codable {
    var staffId: Int
    var nameRu: String
    var nameEn: String
    var description: String?
    var posterUrl: String
    var professionKey: String
}

// Similar films
struct SimilarFilms: Codable {
    var total: Int
    var items: [SimilarFilm]
}

struct SimilarFilm: Codable {
    var filmId: Int
    var nameRu: String
    var nameEn: String
    var nameOriginal: String
    var posterUrl: String
}

// Person Data
struct Person: Codable {
    var personId: Int
    var nameRu: String
    var nameEn: String
    var posterUrl: String
    var growth: Int
    var birthday: String?
    var death: String?
    var age: Int
    var birthplace: String?
    var deathplace: String?
    var profession: String
    var facts: [String]
    var films: [PersonFilm]
}

// Person Film
struct PersonFilm: Codable, Hashable {
    var filmId: Int
    var nameRu: String?
    var nameEn: String?
    var rating: String?
}

// Search film
struct SearchFilm: Codable {
    var keyword: String
    var films: [FilmBaseData]
}

// Search actor
struct SearchActor: Codable {
    var items: [ActorsSearchResult]
}

// Finding actor
struct ActorsSearchResult: Codable {
    var kinopoiskId: Int
    var nameRu: String?
    var nameEn: String?
    var posterUrl: String
}
