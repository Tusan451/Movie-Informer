//
//  FilmsCollectionHeaderView.swift
//  Movie Informer
//
//  Created by Olegio on 08.11.2022.
//

import SwiftUI

struct FilmsCollectionHeaderView: View {
    let imageName: String
    let title: String
    let filmsCount: Int
    let viewed: Int
    
    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 18) {
                HStack(spacing: 20) {
                    Image(imageName)
                        .resizable()
                        .frame(width: 100, height: 100)
                    
                    Text(title)
                        .font(.custom("Inter-Bold", size: 26))
                        .foregroundColor(Color("Text Main"))
                        .frame(width: 230, alignment: .leading)
                }
                .frame(width: UIScreen.main.bounds.width - 40, height: 100, alignment: .leading)
                
                Text("Рейтинг составлен по результатам голосования посетителей сайта kinopoisk.ru. Любой желающий может принять в нем участие, проголосовав за свой любимый фильм.")
                    .font(.custom("Inter-Regular", size: 15))
                    .foregroundColor(Color("Text Main"))
                    .lineSpacing(4)
                    .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
                
                HStack(spacing: 4) {
                    HStack(spacing: 4) {
                        Text("Вы посмотрели")
                            .font(.custom("Inter-SemiBold", size: 14))
                            .foregroundColor(Color("Text Secondary"))
                        Text("\(viewed)")
                            .font(.custom("Inter-SemiBold", size: 14))
                            .foregroundColor(viewed > 0 ? Color("Blue Accent") : Color("Text Secondary"))
                        Text("из \(filmsCount) фильмов")
                            .font(.custom("Inter-SemiBold", size: 14))
                            .foregroundColor(Color("Text Secondary"))
                    }
                    .frame(width: 260, alignment: .leading)
                    
                    LinearProgressBarView(
                        width: 70,
                        height: 12,
                        viewed: viewed,
                        filmsCount: filmsCount
                    )
                }
                .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
            }
            Divider()
                .overlay(Color("Back Secondary"))
                .frame(width: UIScreen.main.bounds.width - 40)
        }
        .frame(width: UIScreen.main.bounds.width, height: 300, alignment: .bottom)
    }
}

struct FilmsCollectionHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        FilmsCollectionHeaderView(
            imageName: "250 лучших фильмов",
            title: "250 лучших фильмов",
            filmsCount: 250,
            viewed: 150
        )
    }
}
