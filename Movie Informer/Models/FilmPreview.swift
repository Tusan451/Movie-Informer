//
//  FilmPreview.swift
//  Movie Informer
//
//  Created by Olegio on 08.11.2022.
//

import Foundation

struct FilmPreview: Identifiable {
    var id: Int
    var image: String
    var title: String
    var titleEn: String
    var genre: String
    var year: String
    var country: String
    var length: String
    var rating: String
    var votesCount: Int
    
    static func getFilmsPreviews() -> [FilmPreview] {
        return [
            FilmPreview(
                id: 1,
                image: "https://kinopoiskapiunofficial.tech/images/posters/kp/435.jpg",
                title: "Зеленая миля",
                titleEn: "The Green Mile",
                genre: "драма, криминал",
                year: "1999",
                country: "США",
                length: "03:09",
                rating: "9.1",
                votesCount: 813305
            ),
            FilmPreview(
                id: 2,
                image: "https://kinopoiskapiunofficial.tech/images/posters/kp/329.jpg",
                title: "Список Шиндлера",
                titleEn: "Schindler's List",
                genre: "драма, биография, военный, история",
                year: "1993",
                country: "США",
                length: "03:15",
                rating: "8.8",
                votesCount: 445474
            ),
            FilmPreview(
                id: 3,
                image: "https://kinopoiskapiunofficial.tech/images/posters/kp/326.jpg",
                title: "Побег из Шоушенка",
                titleEn: "The Shawshank Redemption",
                genre: "драма",
                year: "1994",
                country: "США",
                length: "02:22",
                rating: "9.1",
                votesCount: 861320
            ),
            FilmPreview(
                id: 4,
                image: "https://kinopoiskapiunofficial.tech/images/posters/kp/448.jpg",
                title: "Форрест Гамп",
                titleEn: "Forrest Gump",
                genre: "драма, мелодрама, комедия, военный, история",
                year: "1994",
                country: "США",
                length: "02:22",
                rating: "8.9",
                votesCount: 739808
            ),
            FilmPreview(
                id: 5,
                image: "https://kinopoiskapiunofficial.tech/images/posters/kp/3498.jpg",
                title: "Властелин колец: Возвращение короля",
                titleEn: "The Lord of the Rings: The Return of the King",
                genre: "драма, приключения, фэнтези",
                year: "2003",
                country: "США, Новая Зеландия",
                length: "03:21",
                rating: "8.7",
                votesCount: 530415
            ),
            FilmPreview(
                id: 6,
                image: "https://kinopoiskapiunofficial.tech/images/posters/kp/328.jpg",
                title: "Властелин колец: Братство Кольца",
                titleEn: "The Lord of the Rings: The Fellowship of the Ring",
                genre: "драма, приключения, фэнтези",
                year: "2001",
                country: "США, Новая Зеландия",
                length: "02:58",
                rating: "8.6",
                votesCount: 584439
            ),
        ]
    }
}
