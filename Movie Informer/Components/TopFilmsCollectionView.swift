//
//  TopFilmsCollectionView.swift
//  Movie Informer
//
//  Created by Olegio on 15.11.2022.
//

import SwiftUI

struct TopFilmsCollectionView: View {
    let filmsTopCollection = [FilmBaseData]()
    
    var body: some View {
        LazyVStack {
            ForEach(Array(filmsTopCollection.enumerated()), id: \.offset) { (index, film) in
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
                    loadMoreContent(CurrentFilm: film)
                }
            }
        }
    }
}

struct TopFilmsCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        TopFilmsCollectionView()
    }
}
