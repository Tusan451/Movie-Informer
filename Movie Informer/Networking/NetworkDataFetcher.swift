//
//  NetworkDataFetcher.swift
//  Movie Informer
//
//  Created by Olegio on 09.11.2022.
//

import Foundation

class NetworkDataFetcher: ObservableObject {
    
    let networkService = NetworkService()
    
    func fetchData(urlString: String, responce: @escaping (FilmResponce?) -> Void) {
        networkService.request(urlString: urlString) { result in
            switch result {
            case .success(let data):
                do {
                    let films = try JSONDecoder().decode(FilmResponce.self, from: data)
                    responce(films)
                } catch let jsonError {
                    print("Failed to decode json", jsonError)
                }
            case .failure(let error):
                print("Error recieved requesting data: \(error.localizedDescription)")
                responce(nil)
            }
        }
    }
}
