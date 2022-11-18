//
//  TrailerView.swift
//  Movie Informer
//
//  Created by Olegio on 16.11.2022.
//

import SwiftUI
import WebKit

struct TrailerView: UIViewRepresentable {
    let urlString: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let videoUrl = URL(string: urlString) else { return }
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: videoUrl))
    }
}
