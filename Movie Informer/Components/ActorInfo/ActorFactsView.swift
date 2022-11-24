//
//  ActorFactsView.swift
//  Movie Informer
//
//  Created by Olegio on 22.11.2022.
//

import SwiftUI

struct ActorFactsView: View {
    let title: String
    let facts: [String]
    
    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.custom("Inter-Bold", size: 20))
                .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
            
            LazyVStack(spacing: 16) {
                ForEach(Array(facts.enumerated()), id: \.offset) { (_, fact) in
                    Text("\u{2022} " + fact)
                        .font(.custom("Inter-Regular", size: 14))
                        .lineSpacing(4)
                        .foregroundColor(Color("Text Main"))
                        .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
                }
            }
        }
    }
}

struct ActorFactsView_Previews: PreviewProvider {
    static var previews: some View {
        ActorFactsView(
            title: "Интересные факты",
            facts: [
                "Его отец был шеф-поваром местного ресторана, мать работала там же официанткой. Томми был в семье третьим ребенком. Через пять лет после его рождения Хэнксы развелись, и по американскому законодательству трех старших детей (Тома, Ларри и Сандру) забрал отец.",
                "Православный христианин. К православной церкви принадлежит и его жена Рита Уилсон.",
                "У Тома Хэнкса английские, немецкие и португальские корни.",
                "Том Хэнкс - второй в истории актер (первым был Спенсер Трэйси), выигрывавший премию «Оскар» два года подряд (за роль в картинах «Филадельфия» (1993) и «Форрест Гамп» (1994))."
            ]
        )
    }
}
