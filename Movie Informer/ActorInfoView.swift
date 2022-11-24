//
//  ActorInfoView.swift
//  Movie Informer
//
//  Created by Olegio on 23.11.2022.
//

import SwiftUI

struct ActorInfoView: View {
    var actorInfo: FilmTeamate?
    
    @State private var actorInfoById: Person? = nil
    @State private var films = [PersonFilm]()
    @State private var topFilms = [FilmInfoById]()
    
    var body: some View {
        ZStack {
            Color("Back Main")
                .ignoresSafeArea()
            
            ScrollView {
                if let actorInfoById = actorInfoById {
                    VStack(spacing: 24) {
                        ActorInfoHeaderView(
                            image: actorInfoById.posterUrl,
                            nameRu: actorInfoById.nameRu,
                            nameEn: actorInfoById.nameEn,
                            profession: actorInfoById.profession,
                            birthDate: actorInfoById.birthday,
                            deathDate: actorInfoById.death
                        )
                        
                        Divider()
                            .overlay(Color("Back Secondary"))
                            .frame(width: UIScreen.main.bounds.width - 40)
                        
                        ActorAboutView(
                            title: "Информация",
                            profession: actorInfoById.profession,
                            birthDate: actorInfoById.birthday,
                            deathDate: actorInfoById.death,
                            birthPlace: actorInfoById.birthplace,
                            deathPlace: actorInfoById.deathplace,
                            growth: actorInfoById.growth,
                            moviesCount: films.count
                        )
                        
                        Divider()
                            .overlay(Color("Back Secondary"))
                            .frame(width: UIScreen.main.bounds.width - 40)
                        
                        ActorFactsView(
                            title: "Интересные факты",
                            facts: actorInfoById.facts
                        )
                        
                        Divider()
                            .overlay(Color("Back Secondary"))
                            .frame(width: UIScreen.main.bounds.width - 40)
                        
                        Text("Популярные фильмы")
                            .font(.custom("Inter-Bold", size: 20))
                            .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
                        
                        LazyVStack(spacing: 20) {
                            ForEach(topFilms.prefix(5), id: \.kinopoiskId) { film in
                                ActorFilmView(
                                    image: film.posterUrl,
                                    title: film.nameRu,
                                    enTitle: film.nameOriginal,
                                    year: film.year,
                                    length: film.filmLength,
                                    countries: film.countries,
                                    genres: film.genres,
                                    rating: setRatingFor(film)
                                )
                            }
                        }
                        
                        Rectangle()
                            .foregroundColor(Color("Back Main"))
                            .frame(width: UIScreen.main.bounds.width, height: 60)
                    }
                } else {
                    // Добавить error view
                    Text("Error data")
                }
            }
        }
        .task {
            checkActor()
//            getTopFiveFilms()
        }
    }
}

struct ActorInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ActorInfoView(
            actorInfo: FilmTeamate(
                staffId: 9144,
                nameRu: "Том Хэнкс",
                nameEn: "Tom Hanks",
                posterUrl: "https://kinopoiskapiunofficial.tech/images/actor_posters/kp/9144.jpg",
                professionKey: "ACTOR"
            )
        )
    }
}


extension ActorInfoView {
    private func loadActorInfoById(_ actorID: Int) {
        
        guard let url = URL(string: ServerUrlStrings.actorUrl.rawValue + "\(actorID)") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        
        URLSession.shared.dataTask(with: request) { data, responce, error in
            if let data = data {
                do {
                    let decodedResponce = try JSONDecoder().decode(Person.self, from: data)
                    DispatchQueue.main.async {
                        self.actorInfoById = decodedResponce
                        
                        for film in decodedResponce.films {
                            if film.rating != nil && (film.rating?.first! == "8" || film.rating?.first! == "9") {
                                self.films.append(film)
                                loadFilmInfoById(film.filmId)
                            }
                        }
                        print(films.count)
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
    
    private func loadFilmInfoById(_ filmID: Int) {
        
        guard let url = URL(string: ServerUrlStrings.baseUrl.rawValue + "\(filmID)") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        
        URLSession.shared.dataTask(with: request) { data, responce, error in
            if let data = data {
                do {
                    let decodedResponce = try JSONDecoder().decode(FilmInfoById.self, from: data)
                    DispatchQueue.main.async {
                        self.topFilms.append(decodedResponce)
                        print(topFilms.count)
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
    
    private func getTopFiveFilms() {
        for film in films.prefix(5) {
            loadFilmInfoById(film.filmId)
        }
    }
    
    private func checkActor() {
        guard let actorInfo = actorInfo else { return }
        loadActorInfoById(actorInfo.staffId)
    }
    
    private func setRatingFor(_ film: FilmInfoById) -> String? {
        if let ratingKinopoisk = film.ratingKinopoisk {
            return String(ratingKinopoisk)
        } else if let ratingAwait = film.ratingAwait {
            return String(ratingAwait) + "%"
        } else {
            return nil
        }
    }
}
