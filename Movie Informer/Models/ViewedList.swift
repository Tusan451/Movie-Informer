//
//  ViewedList.swift
//  Movie Informer
//
//  Created by Olegio on 29.11.2022.
//

import Foundation
import RealmSwift

final class ViewedItem: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var collectionName: String
    @Persisted var filmId: Int
    @Persisted var inViewed: Bool
    @Persisted var nameRu: String?
    @Persisted var nameOriginal: String?
    @Persisted var posterUrl: String
    @Persisted var filmRating: Double?
    @Persisted var ratingAwait: Double?
    @Persisted var year: Int
    @Persisted var filmLength: Int?
    @Persisted var countries = List<CountryViewedData>()
    @Persisted var genres = List<GenreViewedData>()
}

final class CountryViewedData: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: UUID
    @Persisted var countryName: String
    @Persisted(originProperty: "countries") var countryViewedData: LinkingObjects<ViewedItem>
}

final class GenreViewedData: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: UUID
    @Persisted var genreName: String
    @Persisted(originProperty: "genres") var genreViewedData: LinkingObjects<ViewedItem>
}
