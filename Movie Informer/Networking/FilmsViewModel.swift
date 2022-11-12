//
//  FilmsViewModel.swift
//  Movie Informer
//
//  Created by Olegio on 09.11.2022.
//

import Foundation
import Combine

class FilmsViewModel: ObservableObject {
    @Published var films = [FilmBaseData]()
    @Published var pagesCount = 0
    @Published var isLoadingPage = false
    private var currentPage = 1
    
    func loadMoreContentIfNeeded(currentFilm film: FilmBaseData?, urlString: String) {
        guard let film = film else {
            loadMoreContent(urlString: urlString)
            return
        }
        
        let thresholdIndex = films.index(films.endIndex, offsetBy: -5)
        if films.firstIndex(where: { $0.filmId == film.filmId }) == thresholdIndex {
            loadMoreContent(urlString: urlString)
        }
    }
    
    func loadMoreContent(urlString: String) {
        guard !isLoadingPage && !(currentPage > pagesCount) else { return }
        
        isLoadingPage = true
        
        guard let url = URL(string: urlString + "\(currentPage)") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("6436b8a3-54c4-487f-963c-ad9773c07c76", forHTTPHeaderField: "X-API-KEY")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: FilmResponce.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { responce in
                self.pagesCount = responce.pagesCount
                self.isLoadingPage = false
                self.currentPage += 1
            })
            .map({ responce in
                return self.films + responce.films
            })
            .catch({ _ in Just(self.films)})
            .assign(to: &$films)
    }
}


//var filmsResponce: FilmResponce?
//
//var films: [FilmBaseData] {
//    guard let films = filmsResponce?.films else { return [] }
//    return films
//}
//
//func fetchFilms(from urlString: String) {
//    NetworkService().requestFilmsData(urlString: urlString) { result in
//        switch result {
//        case .success(let filmsData):
//            DispatchQueue.main.async {
//                self.filmsResponce = filmsData
//            }
//            print("Ok")
//        case .failure(let error):
//            print("Error \(error.localizedDescription)")
//        }
//    }
//}
