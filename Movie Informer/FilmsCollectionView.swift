//
//  FilmsCollectionView.swift
//  Movie Informer
//
//  Created by Olegio on 08.11.2022.
//

import SwiftUI

struct FilmsCollectionView: View {
    let filmsCollection: FilmsCollection
    let filmPreviews = FilmPreview.getFilmsPreviews()
    
    var body: some View {
        ZStack {
            Color("Back Main")
                .ignoresSafeArea()
            ScrollView {
                VStack() {
                    FilmsCollectionHeaderView(
                        imageName: filmsCollection.image,
                        title: filmsCollection.title,
                        filmsCount: filmsCollection.filmsCount,
                        viewed: filmsCollection.viewed
                    )
                    
                    ForEach(filmPreviews) { preview in
                        NavigationLink(destination: FilmInfoView()) {
                            FilmPreviewRowView(
                                image: preview.image,
                                position: preview.id,
                                title: preview.title,
                                titleEn: preview.titleEn,
                                length: preview.length,
                                genre: preview.genre,
                                year: preview.year,
                                rating: preview.rating,
                                votesCount: preview.votesCount
                            )
                        }
                    }
                    .navigationTitle("Фильмы")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
        }
    }
}

struct FilmsCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        FilmsCollectionView(
            filmsCollection: FilmsCollection(
                id: 1,
                image: "250 лучших фильмов",
                title: "250 лучших фильмов",
                filmsCount: 250,
                viewed: 15
            )
        )
    }
}
