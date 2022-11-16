//
//  FilmsCollectionSecondView.swift
//  Movie Informer
//
//  Created by Olegio on 15.11.2022.
//

import SwiftUI

struct FilmsCollectionSecondView: View {
    let filmsCollection: FilmsCollection
    @State private var currentPage = 1
    @State private var pagesCount = 0
    @State private var filmsTop = [FilmBaseData]()
    @State private var filmsGenre = [GenreFilmData]()
    
    var body: some View {
        ZStack {
            Color("Back Main")
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    FilmsCollectionHeaderView(
                        imageName: filmsCollection.image,
                        title: filmsCollection.title,
                        filmsCount: filmsCollection.filmsCount,
                        viewed: filmsCollection.viewed
                    )
                    LazyVStack {
                        if filmsTop.count != 0 {
                            ForEach(Array(filmsTop.enumerated()), id: \.offset) { (index, film) in
                                NavigationLink(destination: FilmInfoView()) {
                                    FilmPreviewRowView(
                                        image: film.posterUrl,
                                        position: index + 1,
                                        title: film.nameRu,
                                        titleEn: film.nameEn,
                                        length: film.filmLength,
                                        countries: film.countries,
                                        genres: film.genres,
                                        year: film.year,
                                        rating: film.rating,
                                        votesCount: film.ratingVoteCount
                                    )
                                }
                                .onAppear {
                                    loadMoreContentForTopCollection(CurrentFilm: film)
                                }
                            }
                        } else {
                            ForEach(Array(filmsGenre.enumerated()), id: \.offset) { (index, filmGenre) in
                                NavigationLink(destination: FilmInfoView()) {
                                    FilmPreviewRowView(
                                        image: filmGenre.posterUrl,
                                        position: index + 1,
                                        title: filmGenre.nameRu ?? filmGenre.nameOriginal ?? "",
                                        titleEn: filmGenre.nameOriginal,
                                        length: "",
                                        countries: filmGenre.countries,
                                        genres: filmGenre.genres,
                                        year: setYear(year: filmGenre.year),
                                        rating: "",
                                        votesCount: 0
                                    )
                                }
                                .onAppear {
                                    loadMoreContentForGenreCollection(CurrentFilm: filmGenre)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Фильмы")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        .task {
            checkFilmsCollectionID()
        }
    }
}

struct FilmsCollectionSecondView_Previews: PreviewProvider {
    static var previews: some View {
        FilmsCollectionSecondView(
            filmsCollection: FilmsCollection(
                id: 1,
                urlString: "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_250_BEST_FILMS&page=",
                image: "250 лучших фильмов",
                title: "250 лучших фильмов",
                filmsCount: 250,
                viewed: 15
            )
        )
    }
}


extension FilmsCollectionSecondView {
    
    func loadMoreContentForTopCollection(CurrentFilm film: FilmBaseData?) {
        
        guard currentPage < 4 else { return }
        
        guard let film = film else { return }
        
        let thresholdIndex = filmsTop.index(filmsTop.endIndex, offsetBy: -1)
        
        if filmsTop.firstIndex(where: { $0.filmId == film.filmId}) == thresholdIndex {
            loadTopFilms()
        }
        
    }
    
    func loadMoreContentForGenreCollection(CurrentFilm film: GenreFilmData?) {
        
        guard currentPage < 4 else { return }
        
        guard let film = film else { return }
        
        let thresholdIndex = filmsGenre.index(filmsGenre.endIndex, offsetBy: -1)
        
        if filmsGenre.firstIndex(where: { $0.kinopoiskId == film.kinopoiskId}) == thresholdIndex {
            loadGenreFilms()
        }
        
    }
    
    private func loadTopFilms() {
        
        guard let url = URL(string: filmsCollection.urlString + "\(currentPage)") else {
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
                    let decodedResponce = try JSONDecoder().decode(FilmResponce.self, from: data)
                    DispatchQueue.main.async {
                        self.filmsTop += decodedResponce.films
                        self.pagesCount = decodedResponce.pagesCount
                        self.currentPage += 1
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
    
    private func loadGenreFilms() {
        guard let url = URL(string: filmsCollection.urlString + "\(currentPage)") else {
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
                    let decodedResponce = try JSONDecoder().decode(GenreFilmsCollection.self, from: data)
                    DispatchQueue.main.async {
                        self.filmsGenre += decodedResponce.items
                        self.pagesCount = decodedResponce.totalPages
                        self.currentPage += 1
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
    
    private func checkFilmsCollectionID() {
        if filmsCollection.id == 1 || filmsCollection.id == 2 {
            loadTopFilms()
        } else {
            loadGenreFilms()
        }
    }
    
    private func setYear(year: Int) -> String {
        return String(year)
    }
}
