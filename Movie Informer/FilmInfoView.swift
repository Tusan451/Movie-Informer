//
//  FilmInfoView.swift
//  Movie Informer
//
//  Created by Olegio on 09.11.2022.
//

import SwiftUI
import AVKit

struct FilmInfoView: View {
    var film: FilmBaseData? = nil
    
    @State private var showingTrailer = false
    @State private var addedInBookmarks = false
    @State private var addedInViewed = false
    
    @State private var filmTrailers = [FilmTrailer]()
    
    var body: some View {
        if let film = film {
            ZStack {
                Color("Back Main")
                    .ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 24) {
                        VStack(spacing: 16) {
                            FilmInfoHeaderView(
                                image: film.posterUrl,
                                rating: film.rating,
                                filmTitleRu: film.nameRu,
                                filmTitleEn: film.nameEn,
                                year: film.year,
                                length: film.filmLength,
                                countries: film.countries,
                                genres: film.genres,
                                ageLimit: "16+"
                            )
                            
                            ButtonView(
                                width: 98,
                                height: 34,
                                buttonColor: Color("Red Accent"),
                                iconColor: .white,
                                textColor: .white,
                                text: "Трейлер",
                                iconName: "Play") {
                                    showingTrailer.toggle()
                                    loadTrailers()
                            }
                                .popover(isPresented: $showingTrailer) {
                                    ZStack {
                                        Color(.black)
                                            .ignoresSafeArea()
                                        TrailerView(urlString: checkTrailers())
                                    }
                                }
                            
                            Text("\"" + "Пол Эджкомб не верил в чудеса. Пока не столкнулся с одним из них" + "\"")
                                .font(.custom("Inter-Regular", size: 14))
                                .foregroundColor(Color("Text Secondary"))
                                .frame(width: UIScreen.main.bounds.width - 40, alignment: .center)
                                .multilineTextAlignment(.center)
                            
                            HStack {
                                ButtonView(
                                    width: UIScreen.main.bounds.width / 2.3,
                                    height: 50,
                                    buttonColor: addedInBookmarks ? Color("Red Secondary") : Color("Back Secondary"),
                                    iconColor: addedInBookmarks ? Color("Red Accent") : Color("Text Main"),
                                    textColor: Color("Text Main"),
                                    text: addedInBookmarks ? "В закладках" : "В закладки",
                                    iconName: "BookmarkSmall") {
                                        addedInBookmarks.toggle()
                                    }
                                
                                ButtonView(
                                    width: UIScreen.main.bounds.width / 2.3,
                                    height: 50,
                                    buttonColor: addedInViewed ? Color("Tertiary Accent") : Color("Back Secondary"),
                                    iconColor: addedInViewed ? Color("Primary Accent") : Color("Text Main"),
                                    textColor: Color("Text Main"),
                                    text: addedInViewed ? "Просмотрено" : "Посмотрели?",
                                    iconName: "ViewSmall") {
                                        addedInViewed.toggle()
                                    }
                            }
                        }
                        
                        Divider()
                            .overlay(Color("Back Secondary"))
                            .frame(width: UIScreen.main.bounds.width - 40)
                        
                        AboutFilmView(
                            title: "О фильме",
                            description: "Пол Эджкомб — начальник блока смертников в тюрьме «Холодная гора», каждый из узников которого однажды проходит «зеленую милю» по пути к месту казни. Пол повидал много заключённых и надзирателей за время работы. Однако гигант Джон Коффи, обвинённый в страшном преступлении, стал одним из самых необычных обитателей блока.",
                            year: 1999,
                            countries: ["США"],
                            genres: ["драма", "криминал"],
                            director: "Фрэнк Дарабонт",
                            scenario: ["Фрэнк Дарабонт", "Стивен Кинг"],
                            producer: ["Фрэнк Дарабонт", "Дэвид Валдес"],
                            videoMaker: ["Дэвид Тэттерсолл"],
                            budget: 60_000_000,
                            world: 286_801_374,
                            ageLimit: "16+"
                        )
                        
                        Divider()
                            .overlay(Color("Back Secondary"))
                            .frame(width: UIScreen.main.bounds.width - 40)
                        
                        Text("Актеры")
                            .font(.custom("Inter-Bold", size: 20))
                            .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
                        
                        ActorsView(
                            imageUrl: "https://kinopoiskapiunofficial.tech/images/actor_posters/kp/9144.jpg",
                            name: "Том Хэнкс",
                            description: "Paul Edgecomb"
                        )
                        
                        Divider()
                            .overlay(Color("Back Secondary"))
                            .frame(width: UIScreen.main.bounds.width - 40)
                        
                        Text("Похожие фильмы")
                            .font(.custom("Inter-Bold", size: 20))
                            .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
                        
                        SimilarFilmsView(
                            imageUrl: "https://kinopoiskapiunofficial.tech/images/posters/kp/326.jpg",
                            titleRu: "Побег из Шоушенка",
                            titleEn: "The Shawshank Redemption"
                        )
                    }
                    .navigationTitle("О фильме")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
        }
    }
}

struct FilmInfoView_Previews: PreviewProvider {
    static var previews: some View {
        FilmInfoView(film: FilmBaseData(
            filmId: 435,
            nameRu: "Зеленая миля",
            nameEn: "The Green Mile",
            year: "1999",
            filmLength: "03:09",
            countries: [FilmCountry(country: "США")],
            genres: [Genre(genre: "драма"), Genre(genre: "криминал")],
            rating: "9.1",
            ratingVoteCount: 813305,
            posterUrl: "https://kinopoiskapiunofficial.tech/images/posters/kp/435.jpg"
        )
        )
    }
}

extension FilmInfoView {
    
    private func loadTrailers() {
        guard let film = film else { return }
        
        guard let url = URL(string: ServerUrlStrings.trailers.rawValue + "\(film.filmId)/videos") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("6436b8a3-54c4-487f-963c-ad9773c07c76", forHTTPHeaderField: "X-API-KEY")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        
        URLSession.shared.dataTask(with: request) { data, responce, error in
            if let data = data {
                do {
                    let decodedResponce = try JSONDecoder().decode(FilmTrailers.self, from: data)
                    DispatchQueue.main.async {
                        self.filmTrailers = decodedResponce.items
                    }
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context) {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
                return
            }
        }.resume()
    }
    
    private func checkTrailers() -> String {
        var url = ""
        for trailer in filmTrailers {
            if trailer.site == "KINOPOISK_WIDGET" {
                url = trailer.url
                break
            }
        }
        print(filmTrailers.count)
        return url
    }
}
