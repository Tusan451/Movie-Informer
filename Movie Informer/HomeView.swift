//
//  HomeView.swift
//  Movie Informer
//
//  Created by Olegio on 07.11.2022.
//

import SwiftUI

struct HomeView: View {
    let filmsCollections = FilmsCollection.getFilmsCollection()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Back Main")
                    .ignoresSafeArea()
                ScrollView {
                    VStack {
                        ForEach(filmsCollections) { collection in
                            NavigationLink(
                                destination: FilmsCollectionView(filmsCollection: collection)) {
                                    FilmsCollectionCellView(
                                        imageName: collection.image,
                                        title: collection.title,
                                        filmsCount: collection.filmsCount,
                                        viewed: collection.viewed
                                    )
                                }
                        }
                        Rectangle()
                            .foregroundColor(Color("Back Main"))
                            .frame(width: UIScreen.main.bounds.width, height: 60)
                    }
                }
                .navigationTitle("Подборки")
            }
        }
        .tint(Color("Secondary Accent"))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HomeView()
        }
    }
}
