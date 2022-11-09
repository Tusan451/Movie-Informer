//
//  LinearProgressBarView.swift
//  Movie Informer
//
//  Created by Olegio on 08.11.2022.
//

import SwiftUI

struct LinearProgressBarView: View {
    let width: CGFloat
    let height: CGFloat
    let viewed: Int
    let filmsCount: Int
    var progress: CGFloat {
        return CGFloat(viewed) / (CGFloat(filmsCount) / 100)
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(Color("Back Secondary"))
                .frame(width: width, height:  height)
                .cornerRadius(height, corners: .allCorners)
            
            Rectangle()
                .foregroundColor(Color("Blue Accent"))
                .frame(width: CGFloat(width * CGFloat(progress) / 100), height: height)
                .cornerRadius(height, corners: .allCorners)
                
        }
    }
}

struct LinearProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        LinearProgressBarView(width: 100, height: 20, viewed: 100, filmsCount: 100)
    }
}
