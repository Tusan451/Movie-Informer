//
//  FilmResponce.swift
//  Movie Informer
//
//  Created by Olegio on 09.11.2022.
//

import Foundation

struct FilmResponce: Codable {
    var films: [FilmBaseData]
}

struct FilmBaseData: Codable {
    var nameRu: String
    var nameEn: String
    var year: String
    var filmLength: String
    var countries: [FilmCountry]
    var genres: [Genre]
    var rating: String
    var ratingVoteCount: Int
    var posterUrl: String
}

struct FilmCountry: Codable {
    var country: String
}

struct Genre: Codable {
    var genre: String
}
