//
//  SearchFilmsActors.swift
//  Movie Informer
//
//  Created by Olegio on 24.11.2022.
//

import SwiftUI

struct SearchFilmsActors: View {
    @State private var searchText = ""
    @State private var findingFilms = [FilmBaseData]()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Back Main")
                    .ignoresSafeArea()
                ForEach(Array(findingFilms.enumerated()), id: \.offset) { (index, film) in
                    NavigationLink(destination: FilmInfoView(filmByTopCollection: film)) {
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
                }
                .searchable(text: $searchText)
                .onChange(of: searchText) { value in
                    if !value.isEmpty && value.count > 2 {
                        loadFilmsBy(value)
                    }
                }
                .navigationTitle("Поиск")
            }
        }
    }
}

struct SearchFilmsActors_Previews: PreviewProvider {
    static var previews: some View {
        SearchFilmsActors()
    }
}


extension SearchFilmsActors {
    private func loadFilmsBy(_ keyword: String) {
        
        guard let url = URL(string: ServerUrlStrings.searchFilms.rawValue + "\(keyword)&page=1") else {
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
                    let decodedResponce = try JSONDecoder().decode(SearchFilm.self, from: data)
                    DispatchQueue.main.async {
                        self.findingFilms = decodedResponce.films
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
