//
//  SearchCategories.swift
//  Movie Informer
//
//  Created by Olegio on 26.11.2022.
//

import SwiftUI

struct SearchCategories: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color("Back Main")
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 16) {
                        Rectangle()
                            .foregroundColor(Color("Back Main"))
                            .frame(width: UIScreen.main.bounds.width, height: 5)
                        
                        NavigationLink(destination: SearchFilms()) {
                            ZStack {
                                Image("Movies")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(
                                        width: UIScreen.main.bounds.width - 40,
                                        height: UIScreen.main.bounds.height / 4.5
                                    )
                                    .clipped()
                                .cornerRadius(8, corners: .allCorners)
                                
                                Text("Фильмы")
                                    .font(.custom("Inter-SemiBold", size: 18))
                                    .foregroundColor(.white)
                                    .frame(width: UIScreen.main.bounds.width - 40)
                            }
                        }
                        
                        NavigationLink(destination: SearchActors()) {
                            ZStack {
                                Image("Actors")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(
                                        width: UIScreen.main.bounds.width - 40,
                                        height: UIScreen.main.bounds.height / 4.5
                                    )
                                    .clipped()
                                .cornerRadius(8, corners: .allCorners)
                                
                                Text("Актеры")
                                    .font(.custom("Inter-SemiBold", size: 18))
                                    .foregroundColor(.white)
                                    .frame(width: UIScreen.main.bounds.width - 40)
                            }
                        }
                        
                        Spacer()
                    }
                }
                .navigationTitle("Поиск")
            }
        }
        .tint(Color("Secondary Accent"))
    }
}

struct SearchCategories_Previews: PreviewProvider {
    static var previews: some View {
        SearchCategories()
    }
}
