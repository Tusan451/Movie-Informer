//
//  AboutFilmView.swift
//  Movie Informer
//
//  Created by Olegio on 16.11.2022.
//

import SwiftUI

struct AboutFilmView: View {
    let title: String
    let description: String?
    let year: String
    let countries: [FilmCountry]
    let genres: [Genre]
    let director: String
    let scenario: [String]
    let producer: [String]
    let videoMaker: [String]
    let budget: Int
    let world: Int
    let ageLimit: String?
    
    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.custom("Inter-Bold", size: 20))
                .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
            
            if let description = description {
                Text(description)
                    .font(.custom("Inter-Regular", size: 14))
                    .lineSpacing(4)
                    .foregroundColor(Color("Text Main"))
                    .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
            }
            
            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    Text("Год производства")
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color("Text Secondary"))
                        .frame(width: UIScreen.main.bounds.width / 2.4, alignment: .leading)
                    
                    Text(year)
                        .font(.custom("Inter-Regular", size: 14))
                        .lineSpacing(4)
                        .foregroundColor(Color("Text Main"))
                        .frame(width: UIScreen.main.bounds.width / 2.3, alignment: .leading)
                }
                
                HStack(spacing: 16) {
                    Text("Страна")
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color("Text Secondary"))
                        .frame(width: UIScreen.main.bounds.width / 2.4, alignment: .leading)
                    
                    Text(setCountries())
                        .font(.custom("Inter-Regular", size: 14))
                        .lineSpacing(4)
                        .foregroundColor(Color("Text Main"))
                        .frame(width: UIScreen.main.bounds.width / 2.3, alignment: .leading)
                }
                
                HStack(spacing: 16) {
                    Text("Жанр")
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color("Text Secondary"))
                        .frame(width: UIScreen.main.bounds.width / 2.4, alignment: .leading)
                    
                    Text(setGenres())
                        .font(.custom("Inter-Regular", size: 14))
                        .lineSpacing(4)
                        .foregroundColor(Color("Text Main"))
                        .frame(width: UIScreen.main.bounds.width / 2.3, alignment: .leading)
                }
                
                if !director.isEmpty {
                    HStack(spacing: 16) {
                        Text("Режиссер")
                            .font(.custom("Inter-Regular", size: 14))
                            .foregroundColor(Color("Text Secondary"))
                            .frame(width: UIScreen.main.bounds.width / 2.4, alignment: .leading)
                        
                        Text(director)
                            .font(.custom("Inter-Regular", size: 14))
                            .lineSpacing(4)
                            .foregroundColor(Color("Text Main"))
                            .frame(width: UIScreen.main.bounds.width / 2.3, alignment: .leading)
                    }
                }
                
                if !producer.isEmpty {
                    HStack(spacing: 16) {
                        Text("Продюссеры")
                            .font(.custom("Inter-Regular", size: 14))
                            .foregroundColor(Color("Text Secondary"))
                            .frame(width: UIScreen.main.bounds.width / 2.4, alignment: .leading)
                        
                        Text(setProdusers())
                            .font(.custom("Inter-Regular", size: 14))
                            .lineSpacing(4)
                            .foregroundColor(Color("Text Main"))
                            .frame(width: UIScreen.main.bounds.width / 2.3, alignment: .leading)
                    }
                }
                
                if !scenario.isEmpty {
                    HStack(spacing: 16) {
                        Text("Сценарий")
                            .font(.custom("Inter-Regular", size: 14))
                            .foregroundColor(Color("Text Secondary"))
                            .frame(width: UIScreen.main.bounds.width / 2.4, alignment: .leading)
                        
                        Text(setScenario())
                            .font(.custom("Inter-Regular", size: 14))
                            .lineSpacing(4)
                            .foregroundColor(Color("Text Main"))
                            .frame(width: UIScreen.main.bounds.width / 2.3, alignment: .leading)
                    }
                }
                
                if !videoMaker.isEmpty {
                    HStack(spacing: 16) {
                        Text("Оператор")
                            .font(.custom("Inter-Regular", size: 14))
                            .foregroundColor(Color("Text Secondary"))
                            .frame(width: UIScreen.main.bounds.width / 2.4, alignment: .leading)
                        
                        Text(setVideomakers())
                            .font(.custom("Inter-Regular", size: 14))
                            .lineSpacing(4)
                            .foregroundColor(Color("Text Main"))
                            .frame(width: UIScreen.main.bounds.width / 2.3, alignment: .leading)
                    }
                }
                
                if budget != 0 {
                    HStack(spacing: 16) {
                        Text("Бюджет")
                            .font(.custom("Inter-Regular", size: 14))
                            .foregroundColor(Color("Text Secondary"))
                            .frame(width: UIScreen.main.bounds.width / 2.4, alignment: .leading)
                        
                        Text("$\(budget)")
                            .font(.custom("Inter-Regular", size: 14))
                            .lineSpacing(4)
                            .foregroundColor(Color("Text Main"))
                            .frame(width: UIScreen.main.bounds.width / 2.3, alignment: .leading)
                    }
                }
                
                if world != 0 {
                    HStack(spacing: 16) {
                        Text("Сборы")
                            .font(.custom("Inter-Regular", size: 14))
                            .foregroundColor(Color("Text Secondary"))
                            .frame(width: UIScreen.main.bounds.width / 2.4, alignment: .leading)
                        
                        Text("$\(world)")
                            .font(.custom("Inter-Regular", size: 14))
                            .lineSpacing(4)
                            .foregroundColor(Color("Text Main"))
                            .frame(width: UIScreen.main.bounds.width / 2.3, alignment: .leading)
                    }
                }
                
                if let ageLimit = ageLimit {
                    HStack(spacing: 16) {
                        Text("Возраст")
                            .font(.custom("Inter-Regular", size: 14))
                            .foregroundColor(Color("Text Secondary"))
                            .frame(width: UIScreen.main.bounds.width / 2.4, alignment: .leading)
                        
                        Text(ageLimit)
                            .font(.custom("Inter-Regular", size: 14))
                            .lineSpacing(4)
                            .foregroundColor(Color("Text Main"))
                            .frame(width: UIScreen.main.bounds.width / 2.3, alignment: .leading)
                    }
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
            year: "1999",
            countries: [FilmCountry(country: "США")],
            genres: [Genre(genre: "драма"), Genre(genre: "криминал")],
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

extension AboutFilmView {
    
    private func setCountries() -> String {
        var text = ""
        
        for country in countries {
            text += country.country + ", "
        }
        
        text.removeLast()
        text.removeLast()
        
        return text
    }
    
    private func setGenres() -> String {
        var text = ""
        
        for genre in genres {
            text += genre.genre + ", "
        }
        
        text.removeLast()
        text.removeLast()
        
        return text
    }
    
    private func setScenario() -> String {
        var text = ""
        
        for teamate in scenario {
            text += teamate + ", "
        }
        
        text.removeLast()
        text.removeLast()
        
        return text
    }
    
    private func setProdusers() -> String {
        var text = ""
        
        for produce in producer {
            text += produce + ", "
        }
        
        text.removeLast()
        text.removeLast()
        
        return text
    }
    
    private func setVideomakers() -> String {
        var text = ""
        
        for operate in videoMaker {
            text += operate + ", "
        }
        
        text.removeLast()
        text.removeLast()
        
        return text
    }
}
