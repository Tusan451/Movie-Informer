//
//  CircularProgressView.swift
//  Movie Informer
//
//  Created by Olegio on 07.11.2022.
//

import SwiftUI

struct CircularProgressView: View {
    let progress: Double
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color("Back Secondary"), lineWidth: 3)
                .frame(width: width, height: height)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color("Blue Accent"),
                    style: StrokeStyle(lineWidth: 3, lineCap: .round)
                )
                .frame(width: width, height: height)
                .rotationEffect(.degrees(-90))
        }
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(progress: 0.2, width: 50, height: 50)
    }
}
