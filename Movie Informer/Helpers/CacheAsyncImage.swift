//
//  CacheAsyncImage.swift
//  Movie Informer
//
//  Created by Olegio on 22.11.2022.
//

import SwiftUI

struct CacheAsyncImage<Content>: View where Content: View {
    private let url: URL
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content
    
    init(
        url: URL,
        scale: CGFloat = 1.0,
        transaction: Transaction = Transaction(),
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }
    
    var body: some View {
        if let cashed = ImageCache[url] {
            let _ = print("cached \(url.absoluteString)")
            content(.success(cashed))
        } else {
            let _ = print("request \(url.absoluteString)")
            AsyncImage(
                url: url,
                scale: scale,
                transaction: transaction
            ) { phase in
                cacheAndRender(phase: phase)
            }
        }
    }
    
    private func cacheAndRender(phase: AsyncImagePhase) -> some View {
        if case .success(let image) = phase {
            ImageCache[url] = image
        }
        
        return content(phase)
    }
}

struct CacheAsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        CacheAsyncImage(url: URL(string: "https://kinopoiskapiunofficial.tech/images/posters/kp/435.jpg")!) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .failure(let error):
                Text("Error: \(error.localizedDescription)")
            case .success(let image):
                image
            @unknown default:
                fatalError()
            }
        }
    }
}


fileprivate class ImageCache {
    static var cashe: [URL: Image] = [:]
    
    static subscript(url: URL) -> Image? {
        get {
            ImageCache.cashe[url]
        }
        set {
            ImageCache.cashe[url] = newValue
        }
    }
}
