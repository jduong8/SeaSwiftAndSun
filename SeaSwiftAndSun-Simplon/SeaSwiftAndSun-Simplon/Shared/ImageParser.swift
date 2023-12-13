//
//  ImageParser.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Jonathan Duong on 13/12/2023.
//

import Foundation
import UIKit

struct ImageLoader {
    
    static let shared = ImageLoader()

    @MainActor
    func loadImage(into imageView: UIImageView,
                   from urlString: String?,
                   defaultImage: UIImage = UIImage(systemName: "photo")!) async {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            imageView.image = defaultImage
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let image = UIImage(data: data)
            
            updateImageView(imageView, with: image ?? defaultImage)
        } catch {
            print("Erreur lors du chargement de l'image: \(error)")
            updateImageView(imageView, with: defaultImage)
        }
    }
    
    private func updateImageView(_ imageView: UIImageView, with image: UIImage) {
        imageView.image = image
    }
}
