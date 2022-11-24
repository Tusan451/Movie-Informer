//
//  ActorAboutView.swift
//  Movie Informer
//
//  Created by Olegio on 22.11.2022.
//

import SwiftUI

struct ActorAboutView: View {
    let title: String
    let profession: String
    let birthDate: String?
    let deathDate: String?
    let birthPlace: String?
    let deathPlace: String?
    let growth: Int
    let moviesCount: Int
    
    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.custom("Inter-Bold", size: 20))
                .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
            
            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    Text("Профессия")
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color("Text Secondary"))
                        .frame(width: UIScreen.main.bounds.width / 2.4, alignment: .leading)
                    
                    Text(profession)
                        .font(.custom("Inter-Regular", size: 14))
                        .lineSpacing(4)
                        .foregroundColor(Color("Text Main"))
                        .frame(width: UIScreen.main.bounds.width / 2.3, alignment: .leading)
                }
                
                if let _ = birthDate {
                    HStack(spacing: 16) {
                        Text("Дата рождения")
                            .font(.custom("Inter-Regular", size: 14))
                            .foregroundColor(Color("Text Secondary"))
                            .frame(width: UIScreen.main.bounds.width / 2.4, alignment: .leading)
                        
                        Text(setBirthDate())
                            .font(.custom("Inter-Regular", size: 14))
                            .lineSpacing(4)
                            .foregroundColor(Color("Text Main"))
                            .frame(width: UIScreen.main.bounds.width / 2.3, alignment: .leading)
                    }
                }
                
                if let _ = deathDate {
                    HStack(spacing: 16) {
                        Text("Дата смерти")
                            .font(.custom("Inter-Regular", size: 14))
                            .foregroundColor(Color("Text Secondary"))
                            .frame(width: UIScreen.main.bounds.width / 2.4, alignment: .leading)
                        
                        Text(setDeathDate())
                            .font(.custom("Inter-Regular", size: 14))
                            .lineSpacing(4)
                            .foregroundColor(Color("Text Main"))
                            .frame(width: UIScreen.main.bounds.width / 2.3, alignment: .leading)
                    }
                }
                
                if let birthPlace = birthPlace {
                    HStack(spacing: 16) {
                        Text("Место рождения")
                            .font(.custom("Inter-Regular", size: 14))
                            .foregroundColor(Color("Text Secondary"))
                            .frame(width: UIScreen.main.bounds.width / 2.4, alignment: .leading)
                        
                        Text(birthPlace)
                            .font(.custom("Inter-Regular", size: 14))
                            .lineSpacing(4)
                            .foregroundColor(Color("Text Main"))
                            .frame(width: UIScreen.main.bounds.width / 2.3, alignment: .leading)
                    }
                }
                
                if let deathPlace = deathPlace {
                    HStack(spacing: 16) {
                        Text("Место смерти")
                            .font(.custom("Inter-Regular", size: 14))
                            .foregroundColor(Color("Text Secondary"))
                            .frame(width: UIScreen.main.bounds.width / 2.4, alignment: .leading)
                        
                        Text(deathPlace)
                            .font(.custom("Inter-Regular", size: 14))
                            .lineSpacing(4)
                            .foregroundColor(Color("Text Main"))
                            .frame(width: UIScreen.main.bounds.width / 2.3, alignment: .leading)
                    }
                }
                
                if growth != 0 {
                    HStack(spacing: 16) {
                        Text("Рост")
                            .font(.custom("Inter-Regular", size: 14))
                            .foregroundColor(Color("Text Secondary"))
                            .frame(width: UIScreen.main.bounds.width / 2.4, alignment: .leading)
                        
                        Text(setGrouth())
                            .font(.custom("Inter-Regular", size: 14))
                            .lineSpacing(4)
                            .foregroundColor(Color("Text Main"))
                            .frame(width: UIScreen.main.bounds.width / 2.3, alignment: .leading)
                    }
                }
                
                HStack(spacing: 16) {
                    Text("Всего фильмов")
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color("Text Secondary"))
                        .frame(width: UIScreen.main.bounds.width / 2.4, alignment: .leading)
                    
                    Text("\(moviesCount)")
                        .font(.custom("Inter-Regular", size: 14))
                        .lineSpacing(4)
                        .foregroundColor(Color("Text Main"))
                        .frame(width: UIScreen.main.bounds.width / 2.3, alignment: .leading)
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width)
    }
}

struct ActorAboutView_Previews: PreviewProvider {
    static var previews: some View {
        ActorAboutView(
            title: "Информация",
            profession: "Актер, Продюсер, Режиссер",
            birthDate: "1956-08-25",
            deathDate: "1958-09-21",
            birthPlace: "Конкорд, Калифорния, США",
            deathPlace: nil,
            growth: 183,
            moviesCount: 406
        )
    }
}

extension ActorAboutView {
    private func setGrouth() -> String {
        var stringGrouth = String(growth)
        stringGrouth.insert(".", at: stringGrouth.index(after: stringGrouth.startIndex))
        
        return stringGrouth + " м"
    }
    
    private func setBirthDate() -> String {
        guard let birthDate = birthDate else { return "" }
        
        var stringDate = ""
        
        let calendar = Calendar.current
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let dateOfBirth = dateFormatter.date(from: birthDate) else { return "" }
        
        let dateComponents = calendar.dateComponents([.day, .month], from: dateOfBirth)
        guard let month = dateComponents.month else { return "" }
        guard let day = dateComponents.day else { return "" }
        
        let zodiakSign = zodiakSignFrom(day: day, month: month)
        
        dateFormatter.dateFormat = "d MMMM yyyy"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        stringDate = dateFormatter.string(from: dateOfBirth) + ", " + zodiakSign
        
        if let deathDate = deathDate {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if let dateOfDeath = dateFormatter.date(from: deathDate) {
                guard let years = calendar.dateComponents(
                    [.year], from: dateOfBirth, to: dateOfDeath
                ).year
                else { return "" }
                stringDate += ", \(years) " + setAgeTitleFrom(age: years)
            }
        } else {
            guard let years = calendar.dateComponents(
                [.year], from: dateOfBirth, to: currentDate
            ).year
            else { return "" }
            stringDate += ", \(years) " + setAgeTitleFrom(age: years)
        }
        
        return stringDate
    }
    
    private func setDeathDate() -> String {
        guard let deathDate = deathDate else { return "" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let dateOfDeath = dateFormatter.date(from: deathDate) else { return "" }
        
        dateFormatter.dateFormat = "d MMMM yyyy"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        return dateFormatter.string(from: dateOfDeath)
    }
    
    private func zodiakSignFrom(day: Int, month: Int) -> String {
        var zodiak = ""
        
        switch (day, month) {
        case let(d, m) where (d >= 21 && m == 3) || (d <= 19 && m == 4):
            zodiak =  "Овен"
        case let(d, m) where (d >= 21 && m == 4) || (d <= 20 && m == 5):
            zodiak = "Телец"
        case let(d, m) where (d >= 21 && m == 5) || (d <= 20 && m == 6):
            zodiak = "Близнецы"
        case let(d, m) where (d >= 21 && m == 6) || (d <= 22 && m == 7):
            zodiak = "Рак"
        case let(d, m) where (d >= 23 && m == 7) || (d <= 22 && m == 8):
            zodiak = "Лев"
        case let(d, m) where (d >= 23 && m == 8) || (d <= 22 && m == 9):
            zodiak = "Дева"
        case let(d, m) where (d >= 23 && m == 9) || (d <= 22 && m == 10):
            zodiak = "Весы"
        case let(d, m) where (d >= 23 && m == 10) || (d <= 21 && m == 11):
            zodiak = "Скорпион"
        case let(d, m) where (d >= 22 && m == 11) || (d <= 21 && m == 12):
            zodiak = "Стрелец"
        case let(d, m) where (d >= 22 && m == 12) || (d <= 19 && m == 1):
            zodiak = "Козерог"
        case let(d, m) where (d >= 20 && m == 1) || (d <= 18 && m == 2):
            zodiak = "Водолей"
        case let(d, m) where (d >= 19 && m == 2) || (d <= 20 && m == 3):
            zodiak = "Рыбы"
        default:
            break
        }
        return zodiak
    }
    
    private func setAgeTitleFrom(age: Int) -> String {
        let age = String(age)
        var ageString = ""
        
        if age == "1" || (age.last == "1" && age.first != "1") {
            ageString = "год"
        } else if (age == "2" || age == "3" || age == "4") || (age.count > 1 && age.first != "1" && (age.last == "2" || age.last == "3" || age.last == "4")) {
            ageString = "года"
        } else {
            ageString = "лет"
        }
        
        return ageString
    }
}
