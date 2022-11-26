//
//  SearchActors.swift
//  Movie Informer
//
//  Created by Olegio on 26.11.2022.
//

import SwiftUI

struct SearchActors: View {
    @State private var searchText = ""
    @State private var findingActors = [ActorsSearchResult]()
    
    var body: some View {
        ZStack {
            Color("Back Main")
                .ignoresSafeArea()
            
            if searchText.isEmpty {
                PlaceholderView(
                    image: "person.text.rectangle.fill",
                    color: Color("Red Accent"),
                    title: "Найти актера",
                    message: "Подробная информация о любимом актере"
                )
            }
            
            ScrollView {
                ForEach(Array(findingActors.enumerated().prefix(10)), id: \.offset) { (index, item) in
                    NavigationLink(destination: ActorInfoView(actorSearchResult: item)) {
                        ActorsView(
                            imageUrl: item.posterUrl,
                            name: item.nameRu,
                            description: item.nameEn
                        )
                    }
                }
                .navigationTitle("Актеры")
                .searchable(text: $searchText, prompt: "Имя актера...")
                .onChange(of: searchText) { value in
                    if !value.isEmpty && value.count > 2 {
                        loadactorsBy(value)
                    } else if value.isEmpty {
                        findingActors.removeAll()
                    }
                }
            }
        }
    }
}

struct SearchActors_Previews: PreviewProvider {
    static var previews: some View {
        SearchActors()
    }
}


extension SearchActors {
    private func loadactorsBy(_ keyword: String) {
        
        guard let decodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .alphanumerics) else {
            print("Error encoding string")
            return
        }
        
        guard let url = URL(string: ServerUrlStrings.searchActors.rawValue + "\(decodedKeyword)&page=1") else {
            print("Invalid URL")
            return
        }
        print(url.description)

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        
        URLSession.shared.dataTask(with: request) { data, responce, error in
            if let data = data {
                do {
                    let decodedResponce = try JSONDecoder().decode(SearchActor.self, from: data)
                    DispatchQueue.main.async {
                        self.findingActors = decodedResponce.items
                    }
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context) {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
                return
            }
        }.resume()
    }
}
