//
//  FilmsCollectionView.swift
//  Movie Informer
//
//  Created by Olegio on 08.11.2022.
//

import SwiftUI

struct FilmsCollectionView: View {
    let filmsCollection: FilmsCollection
    @State private var currentPage = 1
    @State private var pagesCount = 0
    @State private var films = [FilmBaseData]()
    
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
                        ForEach(films, id:\.filmId) { film in
                            NavigationLink(destination: FilmInfoView()) {
                                FilmPreviewRowView(
                                    image: film.posterUrl,
                                    position: 1,
                                    title: film.nameRu,
                                    titleEn: film.nameEn ?? "",
                                    length: film.filmLength,
                                    genre: film.genres.description,
                                    year: film.year,
                                    rating: film.rating ?? "0",
                                    votesCount: film.ratingVoteCount
                                )
                            }
                            .onAppear {
                                loadMoreContent(CurrentFilm: film)
                            }
                        }
                    }
                    .navigationTitle("Фильмы")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
            .task {
                loadFilms()
            }
        }
    }
}

struct FilmsCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        FilmsCollectionView(
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


extension FilmsCollectionView {
    
    func loadMoreContent(CurrentFilm film: FilmBaseData?) {
        
        guard currentPage < 4 else { return }
        
        guard let film = film else { return }
        
        let thresholdIndex = films.index(films.endIndex, offsetBy: -1)
        
        if films.firstIndex(where: { $0.filmId == film.filmId}) == thresholdIndex {
            loadFilms()
        }
        
    }
    
    private func loadFilms() {
        
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
                        self.films += decodedResponce.films
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
}
