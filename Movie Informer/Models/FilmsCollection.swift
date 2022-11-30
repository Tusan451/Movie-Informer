//
//  FilmsCollection.swift
//  Movie Informer
//
//  Created by Olegio on 07.11.2022.
//

import Foundation
import RealmSwift

let apiKey = "bd8e1e8b-cfdb-4e53-a67f-d36f9abfe756"

enum ServerUrlStrings: String {
    case baseUrl = "https://kinopoiskapiunofficial.tech/api/v2.2/films/"
    case actorUrl = "https://kinopoiskapiunofficial.tech/api/v1/staff/"
    case searchFilms = "https://kinopoiskapiunofficial.tech/api/v2.1/films/search-by-keyword?keyword="
    case searchActors = "https://kinopoiskapiunofficial.tech/api/v1/persons?name="
}

struct FilmsCollection: Identifiable {
    var id: Int
    var urlString: String
    var image: String
    var title: String
    var filmsCount: Int
    var viewed: Int {
        return (savedItems.filter { $0.inViewed && $0.collectionName == title }).count
    }
    
    @ObservedResults(SavedItem.self) private var savedItems
        
    static func getFilmsCollection() -> [FilmsCollection] {
        return [
            FilmsCollection(
                id: 1,
                urlString: "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_250_BEST_FILMS&page=",
                image: "250 лучших фильмов",
                title: "250 лучших фильмов",
                filmsCount: 250
            ),
            FilmsCollection(
                id: 2,
                urlString: "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_100_POPULAR_FILMS&page=",
                image: "100 популярных фильмов",
                title: "100 популярных фильмов",
                filmsCount: 100
            ),
            FilmsCollection(
                id: 3,
                urlString: "https://kinopoiskapiunofficial.tech/api/v2.2/films?genres=13&order=RATING&type=FILM&ratingFrom=5&ratingTo=10&yearFrom=1000&yearTo=3000&page=",
                image: "Комедии",
                title: "Комедии",
                filmsCount: 100
            ),
            FilmsCollection(
                id: 4,
                urlString: "https://kinopoiskapiunofficial.tech/api/v2.2/films?genres=4&order=RATING&type=ALL&ratingFrom=5&ratingTo=10&yearFrom=1000&yearTo=3000&page=",
                image: "Про любовь",
                title: "Про любовь",
                filmsCount: 100
            ),
            FilmsCollection(
                id: 5,
                urlString: "https://kinopoiskapiunofficial.tech/api/v2.2/films?genres=1&order=RATING&type=FILM&ratingFrom=5&ratingTo=10&yearFrom=1000&yearTo=3000&page=",
                image: "Триллеры",
                title: "Триллеры",
                filmsCount: 100
            ),
            FilmsCollection(
                id: 6,
                urlString: "https://kinopoiskapiunofficial.tech/api/v2.2/films?genres=2&order=RATING&type=FILM&ratingFrom=5&ratingTo=10&yearFrom=1000&yearTo=3000&page=",
                image: "Драмы",
                title: "Драмы",
                filmsCount: 100
            ),
            FilmsCollection(
                id: 7,
                urlString: "https://kinopoiskapiunofficial.tech/api/v2.2/films?genres=17&order=RATING&type=FILM&ratingFrom=5&ratingTo=10&yearFrom=1000&yearTo=3000&page=",
                image: "Ужасы",
                title: "Ужасы",
                filmsCount: 100
            ),
            FilmsCollection(
                id: 8,
                urlString: "https://kinopoiskapiunofficial.tech/api/v2.2/films?genres=6&order=RATING&type=FILM&ratingFrom=5&ratingTo=10&yearFrom=1000&yearTo=3000&page=",
                image: "Фантастика",
                title: "Фантастика",
                filmsCount: 100
            ),
            FilmsCollection(
                id: 9,
                urlString: "https://kinopoiskapiunofficial.tech/api/v2.2/films?genres=7&order=RATING&type=FILM&ratingFrom=5&ratingTo=10&yearFrom=1000&yearTo=3000&page=",
                image: "Приключения",
                title: "Приключения",
                filmsCount: 100
            ),
            FilmsCollection(
                id: 10,
                urlString: "https://kinopoiskapiunofficial.tech/api/v2.2/films?genres=12&order=RATING&type=FILM&ratingFrom=5&ratingTo=10&yearFrom=1000&yearTo=3000&page=",
                image: "Фэнтези",
                title: "Фэнтези",
                filmsCount: 100
            ),
            FilmsCollection(
                id: 11,
                urlString: "https://kinopoiskapiunofficial.tech/api/v2.2/films?genres=3&order=RATING&type=FILM&ratingFrom=5&ratingTo=10&yearFrom=1000&yearTo=3000&page=",
                image: "Криминал",
                title: "Криминал",
                filmsCount: 100
            ),
            FilmsCollection(
                id: 12,
                urlString: "https://kinopoiskapiunofficial.tech/api/v2.2/films?genres=15&order=RATING&type=FILM&ratingFrom=5&ratingTo=10&yearFrom=1000&yearTo=3000&page=",
                image: "Исторические",
                title: "Исторические",
                filmsCount: 100
            ),
            FilmsCollection(
                id: 13,
                urlString: "https://kinopoiskapiunofficial.tech/api/v2.2/films?genres=22&order=RATING&type=ALL&ratingFrom=5&ratingTo=10&yearFrom=1000&yearTo=3000&page=",
                image: "Документальные",
                title: "Документальные",
                filmsCount: 100
            ),
            FilmsCollection(
                id: 14,
                urlString: "https://kinopoiskapiunofficial.tech/api/v2.2/films?genres=8&order=RATING&type=FILM&ratingFrom=5&ratingTo=10&yearFrom=1000&yearTo=3000&page=",
                image: "Биографии",
                title: "Биографии",
                filmsCount: 100
            ),
            FilmsCollection(
                id: 15,
                urlString: "https://kinopoiskapiunofficial.tech/api/v2.2/films?genres=21&order=RATING&type=FILM&ratingFrom=5&ratingTo=10&yearFrom=1000&yearTo=3000&page=",
                image: "Спортивные",
                title: "Спортивные",
                filmsCount: 100
            ),
            FilmsCollection(
                id: 16,
                urlString: "https://kinopoiskapiunofficial.tech/api/v2.2/films?genres=14&order=RATING&type=ALL&ratingFrom=5&ratingTo=10&yearFrom=1000&yearTo=3000&page=",
                image: "Военные",
                title: "Военные",
                filmsCount: 100
            ),
            FilmsCollection(
                id: 17,
                urlString: "https://kinopoiskapiunofficial.tech/api/v2.2/films?genres=19&order=RATING&type=ALL&ratingFrom=5&ratingTo=10&yearFrom=1000&yearTo=3000&page=",
                image: "Семейные",
                title: "Семейные",
                filmsCount: 100
            ),
            FilmsCollection(
                id: 18,
                urlString: "https://kinopoiskapiunofficial.tech/api/v2.2/films?genres=24&order=RATING&type=ALL&ratingFrom=5&ratingTo=10&yearFrom=1000&yearTo=3000&page=",
                image: "Аниме",
                title: "Аниме",
                filmsCount: 100
            ),
            FilmsCollection(
                id: 19,
                urlString: "https://kinopoiskapiunofficial.tech/api/v2.2/films?genres=10&order=RATING&type=ALL&ratingFrom=5&ratingTo=10&yearFrom=1000&yearTo=3000&page=",
                image: "Вестерны",
                title: "Вестерны",
                filmsCount: 100
            ),
            FilmsCollection(
                id: 20,
                urlString: "https://kinopoiskapiunofficial.tech/api/v2.2/films?genres=18&order=RATING&type=ALL&ratingFrom=5&ratingTo=10&yearFrom=1000&yearTo=3000&page=",
                image: "Мультфильмы",
                title: "Мультфильмы",
                filmsCount: 100
            )
        ]
    }
}
