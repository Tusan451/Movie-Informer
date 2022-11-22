//
//  SimilarFilmsView.swift
//  Movie Informer
//
//  Created by Olegio on 16.11.2022.
//

import SwiftUI

struct SimilarFilmsView: View {
    let imageUrl: String
    let titleRu: String
    let titleEn: String?
    
    var body: some View {
        HStack(spacing: 16) {
            if let url = URL(string: imageUrl) {
                CacheAsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 70, height: 105)
                            .cornerRadius(4, corners: .allCorners)
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
                .frame(width: 70, height: 105)
                .cornerRadius(4, corners: .allCorners)
            } else {
                // Добавить ErrorView
                Text("Error")
            }
            
            VStack(spacing: 5) {
                Text(titleRu)
                    .font(.custom("Inter-SemiBold", size: 15))
                    .foregroundColor(Color("Text Main"))
                    .frame(width: UIScreen.main.bounds.width / 1.5, alignment: .topLeading)
                    .multilineTextAlignment(.leading)
                
                if let titleEn = titleEn {
                    Text(titleEn)
                        .font(.custom("Inter-Regular", size: 12))
                        .foregroundColor(Color("Text Main"))
                        .frame(width: UIScreen.main.bounds.width / 1.5, alignment: .leading)
                        .multilineTextAlignment(.leading)
                }
                
            }
            .frame(width: UIScreen.main.bounds.width / 1.5, height: 105, alignment: .topLeading)
        }
        .frame(width: UIScreen.main.bounds.width - 40, alignment: .topLeading)
    }
}

struct SimilarFilmsView_Previews: PreviewProvider {
    static var previews: some View {
        SimilarFilmsView(
            imageUrl: "https://kinopoiskapiunofficial.tech/images/posters/kp/326.jpg",
            titleRu: "Побег из Шоушенка",
            titleEn: "The Shawshank Redemption"
        )
    }
}
