//
//  AgeLimitView.swift
//  Movie Informer
//
//  Created by Olegio on 15.11.2022.
//

import SwiftUI

struct AgeLimitView: View {
    let ageLimit: String?
    
    var body: some View {
        ZStack {
            Text(setAgeText())
                .font(.custom("Inter-SemiBold", size: 12))
                .foregroundColor(Color("Text Secondary"))
                .frame(width: 30, height: 22, alignment: .center)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color("Text Secondary"))
                )
        }
    }
    
    private func setAgeText() -> String {
        guard let ageLimit = ageLimit else { return "" }
        return ageLimit
    }
}

struct AgeLimitView_Previews: PreviewProvider {
    static var previews: some View {
        AgeLimitView(ageLimit: "16+")
    }
}
