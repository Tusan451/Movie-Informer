//
//  URLExtension.swift
//  Movie Informer
//
//  Created by Olegio on 09.11.2022.
//

import Foundation

extension URL {
    static func filmsDataURL() -> URL? {
        guard let url = URL(string: "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_250_BEST_FILMS&page=1") else {
            return nil
        }
        return url
    }
}
