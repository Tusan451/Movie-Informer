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
    
//    var filmsResponce: FilmResponce?
//
//    func fetchData(from urlString: String) {
//        guard let url = URL(string: urlString) else {
//            print("Invalid URL")
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.addValue("6436b8a3-54c4-487f-963c-ad9773c07c76", forHTTPHeaderField: "X-API-KEY")
//        request.addValue("application/json", forHTTPHeaderField: "accept")
//
//        URLSession.shared.dataTask(with: request) { data, responce, error in
//            if let data = data {
//                do {
//                    let decodedResponce = try JSONDecoder().decode(FilmResponce.self, from: data)
//                    DispatchQueue.main.async {
//                        self.filmsResponce = decodedResponce
//                    }
//                } catch let DecodingError.dataCorrupted(context) {
//                    print(context)
//                } catch let DecodingError.keyNotFound(key, context) {
//                    print("Key '\(key)' not found:", context.debugDescription)
//                    print("codingPath:", context.codingPath)
//                } catch let DecodingError.valueNotFound(value, context) {
//                    print("Value '\(value)' not found:", context.debugDescription)
//                    print("codingPath:", context.codingPath)
//                } catch let DecodingError.typeMismatch(type, context) {
//                    print("Type '\(type)' mismatch:", context.debugDescription)
//                    print("codingPath:", context.codingPath)
//                } catch {
//                    print("error: ", error)
//                }
//                return
//            }
//        }.resume()
//    }
    
    func requestFilmsData(urlString: String, completion: @escaping (Result<FilmResponce?, NetworkError>) -> Void) {

        guard let url = URL(string: urlString) else {
            return completion(.failure(.badURL))
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("6436b8a3-54c4-487f-963c-ad9773c07c76", forHTTPHeaderField: "X-API-KEY")
        request.addValue("application/json", forHTTPHeaderField: "accept")

        URLSession.shared.dataTask(with: request) { data, responce, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            let filmsResponce = try? JSONDecoder().decode(FilmResponce.self, from: data)
            if let filmsResponce = filmsResponce {
                completion(.success(filmsResponce))
            } else {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}


