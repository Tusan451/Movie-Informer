//
//  FilmsViewModel.swift
//  Movie Informer
//
//  Created by Olegio on 09.11.2022.
//

import Foundation

class FilmsViewModel: ObservableObject {
    
    var films: [FilmBaseData]?
    
//    var filmsData: [FilmBaseData] {
//        guard let films = films?.films else { return [] }
//        return films
//    }
    
    func fetchFilms() {
        NetworkService().requestFilmsData { result in
            switch result {
            case .success(let films):
                DispatchQueue.main.async {
                    self.films = films
                }
                print("Ok")
            case .failure(let error):
                print("Error \(error.localizedDescription)")
            }
        }
    }
}
