//
//  FilmsCollection.swift
//  Movie Informer
//
//  Created by Olegio on 07.11.2022.
//

import Foundation

struct FilmsCollection: Identifiable {
    var id: Int
    var urlString: String
    var image: String
    var title: String
    var filmsCount: Int
    var viewed: Int
    
    static func getFilmsCollection() -> [FilmsCollection] {
        return [
            FilmsCollection(
                id: 1,
                urlString: "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_250_BEST_FILMS&page=1",
                image: "250 лучших фильмов",
                title: "250 лучших фильмов",
                filmsCount: 250,
                viewed: 15
            ),
            FilmsCollection(
                id: 2,
                urlString: "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_250_BEST_FILMS&page=1",
                image: "100 популярных фильмов",
                title: "100 популярных фильмов",
                filmsCount: 100,
                viewed: 10
            ),
            FilmsCollection(
                id: 3,
                urlString: "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_250_BEST_FILMS&page=1",
                image: "Цифровые релизы года",
                title: "Цифровые релизы года",
                filmsCount: 100,
                viewed: 0
            ),
            FilmsCollection(
                id: 4,
                urlString: "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_250_BEST_FILMS&page=1",
                image: "Триллеры",
                title: "Триллеры",
                filmsCount: 100,
                viewed: 0
            ),
            FilmsCollection(
                id: 5,
                urlString: "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_250_BEST_FILMS&page=1",
                image: "Драмы",
                title: "Драмы",
                filmsCount: 100,
                viewed: 0
            ),
            FilmsCollection(
                id: 6,
                urlString: "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_250_BEST_FILMS&page=1",
                image: "Фантастика",
                title: "Фантастика",
                filmsCount: 100,
                viewed: 0
            ),
            FilmsCollection(
                id: 7,
                urlString: "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_250_BEST_FILMS&page=1",
                image: "Приключения",
                title: "Приключения",
                filmsCount: 100,
                viewed: 0
            ),
        ]
    }
}
