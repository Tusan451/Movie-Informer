//
//  FilmInfoView.swift
//  Movie Informer
//
//  Created by Olegio on 18.11.2022.
//

import SwiftUI

struct FilmInfoView: View {
    var filmByGenreCollection: GenreFilmData? = nil
    var filmByTopCollection: FilmBaseData? = nil
    var filmBySimilarCollection: SimilarFilm? = nil
    
    @State private var showingTrailer = false
    @State private var addedInBookmarks = false
    @State private var addedInViewed = false
    
    @State private var filmInfoById: FilmInfoById? = nil
    @State private var filmTrailers = [FilmTrailer]()
    @State private var filmBoxOffice = [BoxOfficeItem]()
    @State private var filmTeam = [FilmTeamate]()
    @State private var actors = [FilmTeamate]()
    @State private var similarFilms = [SimilarFilm]()
    
    var body: some View {
        ZStack {
            Color("Back Main")
                .ignoresSafeArea()
            ScrollView {
                if let filmInfoById = filmInfoById {
                    VStack(spacing: 24) {
                        VStack(spacing: 16) {
                            FilmInfoHeaderView(
                                image: filmInfoById.posterUrl,
                                rating: setRating(),
                                filmTitleRu: filmInfoById.nameRu ?? filmInfoById.nameOriginal ?? "",
                                filmTitleEn: filmInfoById.nameOriginal ?? nil,
                                year: String(filmInfoById.year),
                                length: setLenght(),
                                countries: filmInfoById.countries,
                                genres: filmInfoById.genres,
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
                                Text("\"" + (filmInfoById.slogan)! + "\"")
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
                            description: haveDescription() ? filmInfoById.description : nil,
                            year: String(filmInfoById.year),
                            countries: filmInfoById.countries,
                            genres: filmInfoById.genres,
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
                                NavigationLink(destination: ActorInfoView(actorInfo: item)) {
                                    ActorsView(
                                        imageUrl: item.posterUrl,
                                        name: item.nameRu.isEmpty ? item.nameEn : item.nameRu,
                                        description: item.description
                                    )
                                }
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
                                    NavigationLink(destination: FilmInfoView(filmBySimilarCollection: film)) {
                                        SimilarFilmsView(
                                            imageUrl: film.posterUrl,
                                            titleRu: film.nameRu,
                                            titleEn: film.nameEn
                                        )
                                    }
                                }
                            }
                            Rectangle()
                                .foregroundColor(Color("Back Main"))
                                .frame(width: UIScreen.main.bounds.width, height: 60)
                        }
                    }
                    .navigationTitle(setNavigationTitle())
                    .navigationBarTitleDisplayMode(.inline)
                } else {
                    // Добавить error view
                    Text("Error data")
                }
            }
        }
        .task {
            checkCurrentFilm()
        }
    }
}

struct FilmInfoSecondView_Previews: PreviewProvider {
    static var previews: some View {
        FilmInfoView(filmByGenreCollection: GenreFilmData(
            kinopoiskId: 435,
            nameRu: "Зеленая миля",
            nameOriginal: "The Green Mile",
            countries: [FilmCountry(country: "США")],
            genres: [Genre(genre: "драма"), Genre(genre: "криминал")],
            ratingKinopoisk: 9.1,
            year: 1999,
            posterUrl: "https://kinopoiskapiunofficial.tech/images/posters/kp/435.jpg"
        )
        )
    }
}


extension FilmInfoView {
    
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
    
    private func loadTrailers(_ filmId: Int) {
        
        guard let url = URL(string: ServerUrlStrings.baseUrl.rawValue + "\(filmId)/videos") else {
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
    
    private func loadFilmBoxOffice(_ filmId: Int) {
        guard let url = URL(string: ServerUrlStrings.baseUrl.rawValue + "\(filmId)/box_office") else {
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
    
    private func loadFilmTeam(_ filmId: Int) {
        guard let url = URL(string: "https://kinopoiskapiunofficial.tech/api/v1/staff?filmId=\(filmId)") else {
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
    
    private func loadSimilarFilms(_ filmId: Int) {
        guard let url = URL(string: ServerUrlStrings.baseUrl.rawValue + "\(filmId)/similars") else {
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
    
    private func setRating() -> String? {
        guard let filmInfoById = filmInfoById else { return nil }
        if let ratingKinopoisk = filmInfoById.ratingKinopoisk {
            return String(ratingKinopoisk)
        } else if let ratingAwait = filmInfoById.ratingAwait {
            return String(ratingAwait) + "%"
        } else {
            return nil
        }
    }
    
    private func setLenght() -> String? {
        guard let filmInfoById = filmInfoById else { return nil }
        guard let lenght = filmInfoById.filmLength else { return nil }
        
        return String(lenght)
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
    
    private func setNavigationTitle() -> String {
        if let _ = filmByGenreCollection {
            return "О фильме"
        } else if let _ = filmByTopCollection {
            return "О фильме"
        } else {
            return "Похожий фильм"
        }
    }
    
    private func checkCurrentFilm() {
        if let filmByGenreCollection = filmByGenreCollection {
            loadFilmInfoById(filmByGenreCollection.kinopoiskId)
            loadTrailers(filmByGenreCollection.kinopoiskId)
            loadFilmBoxOffice(filmByGenreCollection.kinopoiskId)
            loadFilmTeam(filmByGenreCollection.kinopoiskId)
            loadSimilarFilms(filmByGenreCollection.kinopoiskId)
        } else if let filmByTopCollection = filmByTopCollection {
            loadFilmInfoById(filmByTopCollection.filmId)
            loadTrailers(filmByTopCollection.filmId)
            loadFilmBoxOffice(filmByTopCollection.filmId)
            loadFilmTeam(filmByTopCollection.filmId)
            loadSimilarFilms(filmByTopCollection.filmId)
        } else if let filmBySimilarCollection = filmBySimilarCollection {
            loadFilmInfoById(filmBySimilarCollection.filmId)
            loadTrailers(filmBySimilarCollection.filmId)
            loadFilmBoxOffice(filmBySimilarCollection.filmId)
            loadFilmTeam(filmBySimilarCollection.filmId)
        }
    
    }
}
