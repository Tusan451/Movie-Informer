//
//  ActorsView.swift
//  Movie Informer
//
//  Created by Olegio on 16.11.2022.
//

import SwiftUI

struct ActorsView: View {
    let imageUrl: String
    let name: String
    let description: String
    
    var body: some View {
        HStack(spacing: 20) {
            AsyncImage(url: URL(string: imageUrl)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 70, height: 105)
                    .cornerRadius(4, corners: .allCorners)
            } placeholder: {
                ZStack {
                    Color("Tertiary Accent")
                    ProgressView()
                        .tint(Color("Primary Accent"))
                }
            }
            .frame(width: 70, height: 105)
            .cornerRadius(4, corners: .allCorners)
            
            VStack(spacing: 5) {
                Text(name)
                    .font(.custom("Inter-Medium", size: 16))
                    .foregroundColor(Color("Text Main"))
                    .frame(width: UIScreen.main.bounds.width / 1.5, alignment: .leading)
                
                Text(description)
                    .font(.custom("Inter-Medium", size: 12))
                    .foregroundColor(Color("Text Secondary"))
                    .frame(width: UIScreen.main.bounds.width / 1.5, alignment: .leading)
            }
            .frame(height: 105, alignment: .topLeading)
        }
    }
}

struct ActorsView_Previews: PreviewProvider {
    static var previews: some View {
        ActorsView(
            imageUrl: "https://kinopoiskapiunofficial.tech/images/actor_posters/kp/9144.jpg",
            name: "Том Хэнкс",
            description: "Paul Edgecomb"
        )
    }
}
