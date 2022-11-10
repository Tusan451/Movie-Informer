//
//  NetworkService.swift
//  Movie Informer
//
//  Created by Olegio on 09.11.2022.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case noData
    case decodingError
}

class NetworkService {
    
//    func request(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
//        guard let url = URL(string: urlString) else { return }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.addValue("X-API-KEY", forHTTPHeaderField: "6436b8a3-54c4-487f-963c-ad9773c07c76")
//        request.addValue("Content-Type", forHTTPHeaderField: "application/json")
//
//        URLSession.shared.dataTask(with: request) { data, responce, error in
//            DispatchQueue.main.async {
//                if let error = error {
//                    print("Error: \(error.localizedDescription)")
//                    completion(.failure(error))
//                    return
//                }
//                guard let data = data else { return }
//                completion(.success(data))
//            }
//        }
//        .resume()
//    }
    
    func requestFilmsData(completion: @escaping (Result<[FilmBaseData]?, NetworkError>) -> Void) {
        
        guard let url = URL.filmsDataURL() else {
            return completion(.failure(.badURL))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("X-API-KEY", forHTTPHeaderField: "6436b8a3-54c4-487f-963c-ad9773c07c76")
        request.addValue("Content-Type", forHTTPHeaderField: "application/json")
        
        URLSession.shared.dataTask(with: request) { data, responce, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            let filmsResponce = try? JSONDecoder().decode(FilmResponce.self, from: data)
            if let filmsResponce = filmsResponce {
                completion(.success(filmsResponce.films))
            } else {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
