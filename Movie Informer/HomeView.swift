//
//  HomeView.swift
//  Movie Informer
//
//  Created by Olegio on 07.11.2022.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        Text("Home View")
            .font(.custom("Inter-Bold", size: 32))
            .foregroundColor(Color("Text Main"))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
