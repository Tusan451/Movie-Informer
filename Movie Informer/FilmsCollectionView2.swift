//
//  FilmsCollectionView2.swift
//  Movie Informer
//
//  Created by Olegio on 11.11.2022.
//

import SwiftUI

struct FilmsCollectionView2: View {
    @State var urlString = "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_250_BEST_FILMS&page="
    @StateObject var filmsVM = FilmsViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(filmsVM.films, id: \.filmId) { film in
                    Text("\(film.nameRu)")
                        .onAppear {
                            filmsVM.loadMoreContentIfNeeded(currentFilm: film, urlString: urlString)
                        }
                }
            }
        }
        .task {
            await loadFilms()
        }
    }
    
    func loadFilms() async {
        filmsVM.loadMoreContent(urlString: urlString)
    }
}

struct FilmsCollectionView2_Previews: PreviewProvider {
    static var previews: some View {
        FilmsCollectionView2()
    }
}
