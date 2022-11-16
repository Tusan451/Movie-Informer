//
//  FilmDescriptionView.swift
//  Movie Informer
//
//  Created by Olegio on 16.11.2022.
//

import SwiftUI

struct FilmDescriptionView: View {
    let title: String
    let description: String
    
    var body: some View {
        VStack(spacing: 16) {
            Text(title)
                .font(.custom("Inter-Bold", size: 20))
                .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
            
            Text(description)
                .font(.custom("Inter-Regular", size: 14))
                .lineSpacing(4)
                .foregroundColor(Color("Text Main"))
                .frame(width: UIScreen.main.bounds.width - 40, alignment: .leading)
        }
    }
}

struct FilmDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        FilmDescriptionView(
            title: "Описание",
            description: "Пол Эджкомб — начальник блока смертников в тюрьме «Холодная гора», каждый из узников которого однажды проходит «зеленую милю» по пути к месту казни. Пол повидал много заключённых и надзирателей за время работы. Однако гигант Джон Коффи, обвинённый в страшном преступлении, стал одним из самых необычных обитателей блока."
        )
    }
}
