//
//  AboutFilmView.swift
//  Movie Informer
//
//  Created by Olegio on 16.11.2022.
//

import SwiftUI

struct AboutFilmView: View {
    let title: String
    let description: String
    let year: Int
    let countries: [String]
    let genres: [String]
    let director: String
    let scenario: [String]
    let producer: [String]
    let videoMaker: [String]
    let budget: Int
    let world: Int
    let ageLimit: String
    
    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.custom("Inter-Bold", size: 20))
                .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
            
            Text(description)
                .font(.custom("Inter-Regular", size: 14))
                .lineSpacing(4)
                .foregroundColor(Color("Text Main"))
                .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
            
            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    Text("Год производства")
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color("Text Secondary"))
                        .frame(width: UIScreen.main.bounds.width / 2.4, alignment: .leading)
                    
                    Text(String(year))
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color("Text Main"))
                        .frame(width: UIScreen.main.bounds.width / 2.3, alignment: .leading)
                }
                
                HStack(spacing: 16) {
                    Text("Страна")
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color("Text Secondary"))
                        .frame(width: UIScreen.main.bounds.width / 2.4, alignment: .leading)
                    
                    Text(countries[0])
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color("Text Main"))
                        .frame(width: UIScreen.main.bounds.width / 2.3, alignment: .leading)
                }
                
                HStack(spacing: 16) {
                    Text("Жанр")
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color("Text Secondary"))
                        .frame(width: UIScreen.main.bounds.width / 2.4, alignment: .leading)
                    
                    Text(genres[0] + ", " + genres[1])
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color("Text Main"))
                        .frame(width: UIScreen.main.bounds.width / 2.3, alignment: .leading)
                }
                
                HStack(spacing: 16) {
                    Text("Режиссер")
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color("Text Secondary"))
                        .frame(width: UIScreen.main.bounds.width / 2.4, alignment: .leading)
                    
                    Text(director)
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color("Text Main"))
                        .frame(width: UIScreen.main.bounds.width / 2.3, alignment: .leading)
                }
                
                HStack(spacing: 16) {
                    Text("Сценарий")
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color("Text Secondary"))
                        .frame(width: UIScreen.main.bounds.width / 2.4, alignment: .leading)
                    
                    Text(scenario[0] + ", " + scenario[1])
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color("Text Main"))
                        .frame(width: UIScreen.main.bounds.width / 2.3, alignment: .leading)
                }
                
                HStack(spacing: 16) {
                    Text("Оператор")
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color("Text Secondary"))
                        .frame(width: UIScreen.main.bounds.width / 2.4, alignment: .leading)
                    
                    Text(videoMaker[0])
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color("Text Main"))
                        .frame(width: UIScreen.main.bounds.width / 2.3, alignment: .leading)
                }
                
                HStack(spacing: 16) {
                    Text("Бюджет")
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color("Text Secondary"))
                        .frame(width: UIScreen.main.bounds.width / 2.4, alignment: .leading)
                    
                    Text("$\(budget)")
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color("Text Main"))
                        .frame(width: UIScreen.main.bounds.width / 2.3, alignment: .leading)
                }
                
                HStack(spacing: 16) {
                    Text("Сборы")
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color("Text Secondary"))
                        .frame(width: UIScreen.main.bounds.width / 2.4, alignment: .leading)
                    
                    Text("$\(world)")
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color("Text Main"))
                        .frame(width: UIScreen.main.bounds.width / 2.3, alignment: .leading)
                }
                
                HStack(spacing: 16) {
                    Text("Возраст")
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color("Text Secondary"))
                        .frame(width: UIScreen.main.bounds.width / 2.4, alignment: .leading)
                    
                    Text(ageLimit)
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color("Text Main"))
                        .frame(width: UIScreen.main.bounds.width / 2.3, alignment: .leading)
                }
            }
        }
    }
}

struct AboutFilmView_Previews: PreviewProvider {
    static var previews: some View {
        AboutFilmView(
            title: "О фильме",
            description: "Пол Эджкомб — начальник блока смертников в тюрьме «Холодная гора», каждый из узников которого однажды проходит «зеленую милю» по пути к месту казни. Пол повидал много заключённых и надзирателей за время работы. Однако гигант Джон Коффи, обвинённый в страшном преступлении, стал одним из самых необычных обитателей блока.",
            year: 1999,
            countries: ["США"],
            genres: ["драма", "криминал"],
            director: "Фрэнк Дарабонт",
            scenario: ["Фрэнк Дарабонт", "Стивен Кинг"],
            producer: ["Фрэнк Дарабонт", "Дэвид Валдес"],
            videoMaker: ["Дэвид Тэттерсолл"],
            budget: 60_000_000,
            world: 286_801_374,
            ageLimit: "16+"
        )
    }
}
