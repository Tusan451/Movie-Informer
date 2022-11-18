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
    @State private var filmInfoById: FilmInfoById? = nil
    @State private var filmBoxOffice = [BoxOfficeItem]()
    @State private var filmTeam = [FilmTeamate]()
    @State private var actors = [FilmTeamate]()
    @State private var similarFilms = [SimilarFilm]()
    
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
                                ageLimit: setAgeLimit()
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
                                        if checkTrailers() {
                                            TrailerView(urlString: trailerUrl())
                                        } else {
                                            VStack(spacing: 12) {
                                                Image(systemName: "xmark.circle")
                                                    .resizable()
                                                    .frame(width: 32, height: 32)
                                                    .foregroundColor(Color("Red Accent"))
                                                
                                                Text("Trailer not found")
                                                    .font(.custom("Inter-Bold", size: 26))
                                                .foregroundColor(.white)
                                            }
                                        }
                                    }
                                }
                            
                            if haveSlogan() {
                                Text("\"" + (filmInfoById?.slogan)! + "\"")
                                    .font(.custom("Inter-Regular", size: 14))
                                    .foregroundColor(Color("Text Secondary"))
                                    .frame(width: UIScreen.main.bounds.width - 40, alignment: .center)
                                    .multilineTextAlignment(.center)
                            }
                            
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
                            description: haveDescription() ? filmInfoById?.description : nil,
                            year: film.year,
                            countries: film.countries,
                            genres: film.genres,
                            director: setDirector(),
                            scenario: setScenario(),
                            producer: setProducer(),
                            videoMaker: setVideoMakers(),
                            budget: setBudget(),
                            world: setAmount(),
                            ageLimit: setAgeLimit()
                        )
                        
                        Divider()
                            .overlay(Color("Back Secondary"))
                            .frame(width: UIScreen.main.bounds.width - 40)
                        
                        Text("Актеры")
                            .font(.custom("Inter-Bold", size: 20))
                            .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
                        
                        LazyVStack(spacing: 20) {
                            ForEach(actors.prefix(10), id: \.staffId) { item in
                                ActorsView(
                                    imageUrl: item.posterUrl,
                                    name: item.nameRu.isEmpty ? item.nameEn : item.nameRu,
                                    description: item.description
                                )
                            }
                        }
                        
                        Divider()
                            .overlay(Color("Back Secondary"))
                            .frame(width: UIScreen.main.bounds.width - 40)
                        
                        if !similarFilms.isEmpty {
                            Text("Похожие фильмы")
                                .font(.custom("Inter-Bold", size: 20))
                                .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
                            
                            LazyVStack(spacing: 20) {
                                ForEach(similarFilms, id: \.filmId) { film in
                                    SimilarFilmsView(
                                        imageUrl: film.posterUrl,
                                        titleRu: film.nameRu,
                                        titleEn: film.nameEn
                                    )
                                }
                            }
                            Rectangle()
                                .foregroundColor(Color("Back Main"))
                                .frame(width: UIScreen.main.bounds.width, height: 60)
                        }
                    }
                    .navigationTitle("О фильме")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
            .task {
                loadFilmInfoById()
                loadFilmBoxOffice()
                loadFilmTeam()
                loadSimilarFilms()
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
        
        guard let url = URL(string: ServerUrlStrings.baseUrl.rawValue + "\(film.filmId)/videos") else {
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
    
    private func loadFilmInfoById() {
        guard let film = film else { return }
        
        guard let url = URL(string: ServerUrlStrings.baseUrl.rawValue + "\(film.filmId)") else {
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
                    let decodedResponce = try JSONDecoder().decode(FilmInfoById.self, from: data)
                    DispatchQueue.main.async {
                        self.filmInfoById = decodedResponce
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
    
    private func loadFilmBoxOffice() {
        guard let film = film else { return }
        
        guard let url = URL(string: ServerUrlStrings.baseUrl.rawValue + "\(film.filmId)/box_office") else {
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
                    let decodedResponce = try JSONDecoder().decode(FilmBoxOffice.self, from: data)
                    DispatchQueue.main.async {
                        self.filmBoxOffice = decodedResponce.items
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
    
    private func loadFilmTeam() {
        guard let film = film else { return }
        
        guard let url = URL(string: "https://kinopoiskapiunofficial.tech/api/v1/staff?filmId=\(film.filmId)") else {
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
                    let decodedResponce = try JSONDecoder().decode([FilmTeamate].self, from: data)
                    DispatchQueue.main.async {
                        self.filmTeam = decodedResponce
                        self.actors = filmTeam.filter { $0.professionKey.hasPrefix("ACTOR") }
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
    
    private func loadSimilarFilms() {
        guard let film = film else { return }
        
        guard let url = URL(string: ServerUrlStrings.baseUrl.rawValue + "\(film.filmId)/similars") else {
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
                    let decodedResponce = try JSONDecoder().decode(SimilarFilms.self, from: data)
                    DispatchQueue.main.async {
                        self.similarFilms = decodedResponce.items
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
    
    private func trailerUrl() -> String {
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
    
    private func checkTrailers() -> Bool {
        var checkTrailers = false
        for trailer in filmTrailers {
            if trailer.site == "KINOPOISK_WIDGET" {
                checkTrailers.toggle()
                break
            }
        }
        print(filmTrailers.count)
        return checkTrailers
    }
    
    private func setAgeLimit() -> String? {
        guard let filmInfoById = filmInfoById else { return nil }
        guard var ageLimit = filmInfoById.ratingAgeLimits else { return nil }
        
        ageLimit.removeAll { character in
            character == "a" || character == "g" || character == "e"
        }
        
        return ageLimit + "+"
    }
    
    private func haveSlogan() -> Bool {
        guard let filmInfoById = filmInfoById else { return false }
        guard let _ = filmInfoById.slogan else { return false }
        
        return true
    }
    
    private func haveDescription() -> Bool {
        guard let filmInfoById = filmInfoById else { return false }
        guard let _ = filmInfoById.description else { return false }
        
        return true
    }
    
    private func setBudget() -> Int {
        var budget = 0
        
        for item in filmBoxOffice {
            if item.type == "BUDGET" {
                budget = item.amount
            }
        }
        return budget
    }
    
    private func setAmount() -> Int {
        var amount = 0
        
        for item in filmBoxOffice {
            if item.type == "RUS" || item.type == "WORLD" {
                amount = item.amount
            }
        }
        return amount
    }
    
    private func setDirector() -> String {
        guard !filmTeam.isEmpty else { return "" }
        
        var director = ""
        
        for teamate in filmTeam {
            if teamate.professionKey == "DIRECTOR" {
                if !teamate.nameRu.isEmpty {
                    director = teamate.nameRu
                } else {
                    director = teamate.nameEn
                }
            }
        }
        
        return director
    }
    
    private func setScenario() -> [String] {
        guard !filmTeam.isEmpty else { return [] }
        
        var scenarioTeam: [String] = []
        
        for teamate in filmTeam {
            if teamate.professionKey == "WRITER" {
                if !teamate.nameRu.isEmpty {
                    scenarioTeam.append(teamate.nameRu)
                } else {
                    scenarioTeam.append(teamate.nameEn)
                }
            }
        }
        
        return scenarioTeam
    }
    
    private func setProducer() -> [String] {
        guard !filmTeam.isEmpty else { return [] }
        
        var producers: [String] = []
        
        for producer in filmTeam {
            if producer.professionKey == "PRODUCER" {
                if !producer.nameRu.isEmpty {
                    producers.append(producer.nameRu)
                } else {
                    producers.append(producer.nameEn)
                }
            }
        }
        
        return producers
    }
    
    private func setVideoMakers() -> [String] {
        guard !filmTeam.isEmpty else { return [] }
        
        var videomakers: [String] = []
        
        for videomaker in filmTeam {
            if videomaker.professionKey == "OPERATOR" {
                if !videomaker.nameRu.isEmpty {
                    videomakers.append(videomaker.nameRu)
                } else {
                    videomakers.append(videomaker.nameEn)
                }
            }
        }
        
        return videomakers
    }
}
