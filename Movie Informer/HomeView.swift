//
//  HomeView.swift
//  Movie Informer
//
//  Created by Olegio on 07.11.2022.
//

import SwiftUI

struct HomeView: View {
    let filmsCollections = FilmsCollection.getFilmsCollections()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Back Main")
                    .ignoresSafeArea()
                ScrollView {
                    VStack {
                        ForEach(filmsCollections) { collection in
                            FilmsCollectionCellView(
                                imageName: collection.image,
                                title: collection.title,
                                filmsCount: collection.filmsCount,
                                viewed: collection.viewed
                            )
                        }
                    }
                }
                .navigationTitle("Подборки")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HomeView()
        }
    }
}
