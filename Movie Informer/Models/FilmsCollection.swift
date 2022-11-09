//
//  FilmsCollection.swift
//  Movie Informer
//
//  Created by Olegio on 07.11.2022.
//

import Foundation

struct FilmsCollection: Identifiable {
    var id: Int
    var image: String
    var title: String
    var filmsCount: Int
    var viewed: Int
    
    static func getFilmsCollection() -> [FilmsCollection] {
        return [
            FilmsCollection(
                id: 1,
                image: "250 лучших фильмов",
                title: "250 лучших фильмов",
                filmsCount: 250,
                viewed: 15
            ),
            FilmsCollection(
                id: 2,
                image: "100 популярных фильмов",
                title: "100 популярных фильмов",
                filmsCount: 100,
                viewed: 10
            ),
            FilmsCollection(
                id: 3,
                image: "Цифровые релизы года",
                title: "Цифровые релизы года",
                filmsCount: 100,
                viewed: 0
            ),
            FilmsCollection(
                id: 4,
                image: "Триллеры",
                title: "Триллеры",
                filmsCount: 100,
                viewed: 0
            ),
            FilmsCollection(
                id: 5,
                image: "Драмы",
                title: "Драмы",
                filmsCount: 100,
                viewed: 0
            ),
            FilmsCollection(
                id: 6,
                image: "Фантастика",
                title: "Фантастика",
                filmsCount: 100,
                viewed: 0
            ),
            FilmsCollection(
                id: 7,
                image: "Приключения",
                title: "Приключения",
                filmsCount: 100,
                viewed: 0
            ),
        ]
    }
}
