//
//  ImageLoader.swift
//  BSWearOnlineShop
//
//  Created by Виктория Щербакова on 17.02.2021.
//

import UIKit
class ImageLoader {
    static let shared = ImageLoader()
    private let cache = NSCache<NSString, UIImage>()
    
    func loadImage(imagePath: String, completion: @escaping (UIImage) -> ()) {
        if let image = cache.object(forKey: imagePath as NSString) {
            DispatchQueue.main.async {
                completion(image)
            }
        } else {
            guard let placeholder = UIImage(named: "placeholder") else {return}
            DispatchQueue.main.async {
                completion(placeholder)
            }
            guard let url = URL(string: imagePath) else {return}
            let task = URLSession.shared.dataTask(with: url) {data, response, error in
                if let data = try? Data(contentsOf: url) {
                    guard let img = UIImage(data: data) else {return}
                    self.cache.setObject(img, forKey: imagePath as NSString)
                    DispatchQueue.main.async {
                        completion(img)
                    }
                }
            }
            
            task.resume()
            
        }
    }
}


