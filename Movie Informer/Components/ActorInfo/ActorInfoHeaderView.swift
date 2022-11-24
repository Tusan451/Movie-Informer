//
//  ActorInfoHeaderView.swift
//  Movie Informer
//
//  Created by Olegio on 22.11.2022.
//

import SwiftUI

struct ActorInfoHeaderView: View {
    let image: String
    let nameRu: String
    let nameEn: String
    let profession: String
    let birthDate: String?
    let deathDate: String?
    
    var body: some View {
        VStack(spacing: 16) {
            if let url = URL(string: image) {
                CacheAsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width / 1.5, height: UIScreen.main.bounds.height / 2)
                            .cornerRadius(8, corners: .allCorners)
                    case .failure(let error):
                        // Добавить ErrorView
                        Text("Error: \(error.localizedDescription)")
                    case .empty:
                        ZStack {
                            Color("Tertiary Accent")
                            ProgressView()
                                .tint(Color("Primary Accent"))
                        }
                    @unknown default:
                        fatalError()
                    }
                }
                .frame(width: UIScreen.main.bounds.width / 1.5, height: UIScreen.main.bounds.height / 2)
                .cornerRadius(8, corners: .allCorners)
                
            } else {
                // Добавить ErrorView
                Text("Error")
            }
            
            VStack(spacing: 12) {
                Text(nameRu)
                    .font(.custom("Inter-Bold", size: 26))
                    .foregroundColor(Color("Text Main"))
                    .frame(width: UIScreen.main.bounds.width - 40, alignment: .center)
                    .multilineTextAlignment(.center)
                
                if nameEn != "" {
                    Text(nameEn)
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(Color("Text Main"))
                        .frame(width: UIScreen.main.bounds.width - 40, alignment: .center)
                        .multilineTextAlignment(.center)
                }
                
                VStack(spacing: 6) {
                    Text(profession)
                        .font(.custom("Inter-Medium", size: 14))
                        .foregroundColor(Color("Text Secondary"))
                        .frame(width: UIScreen.main.bounds.width - 40, alignment: .center)
                        .multilineTextAlignment(.center)
                    
                    if let _ = birthDate {
                        Text(setAge())
                            .font(.custom("Inter-Medium", size: 14))
                            .foregroundColor(Color("Text Secondary"))
                            .frame(width: UIScreen.main.bounds.width - 40, alignment: .center)
                            .multilineTextAlignment(.center)
                    }
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width)
    }
}

struct ActorInfoHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ActorInfoHeaderView(
            image: "https://kinopoiskapiunofficial.tech/images/actor_posters/kp/9144.jpg",
            nameRu: "Том Хэнкс",
            nameEn: "Tom Hanks",
            profession: "Актер, Продюсер, Режиссер",
            birthDate: "1956-08-25",
            deathDate: nil
        )
    }
}

extension ActorInfoHeaderView {
    private func setAge() -> String {
        guard let birthDate = birthDate else { return "" }
        
        var stringYears = ""
        
        let calendar = Calendar.current
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let dateOfBirth = dateFormatter.date(from: birthDate) else { return "" }
        
        if let deathDate = deathDate {
            if let dateOfDeath = dateFormatter.date(from: deathDate) {
                guard let years = calendar.dateComponents(
                    [.year], from: dateOfBirth, to: dateOfDeath
                ).year
                else { return "" }
                stringYears = "\(years) " + setAgeTitleFrom(age: years)
            }
        } else {
            guard let years = calendar.dateComponents(
                [.year], from: dateOfBirth, to: currentDate
            ).year
            else { return "" }
            stringYears = "\(years) " + setAgeTitleFrom(age: years)
        }
        
        return stringYears
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
    
//    private func setAge() -> String {
//        let age = String(age)
//        var ageString = ""
//
//        if age == "1" || (age.last == "1" && age.first != "1") {
//            ageString = age + " год"
//        } else if (age == "2" || age == "3" || age == "4") || (age.count > 1 && age.first != "1" && (age.last == "2" || age.last == "3" || age.last == "4")) {
//            ageString = age + " года"
//        } else {
//            ageString = age + " лет"
//        }
//
//        return ageString
//    }
}
