//
//  NetworkManager.swift
//  BSWearOnlineShop
//
//  Created by Виктория Щербакова on 14.01.2021.
//

import Foundation

class NetworkManager {
    
    func loadDataFromURL<T: Decodable>(urlString: URL, type: T.Type, completion: @escaping ([T]?) -> Void) {
        
        URLSession.shared.dataTask(with: urlString) { (data, _, error) in
            if let error = error {print(error.localizedDescription)}
            guard let data = data else {return}
            guard let json = try? JSONDecoder().decode([String: T].self, from: data) else {
                print("Decode error")
                return
            }
            switch type {
            case is Categories.Type:
                let array = Array(json.values) as! [Categories]
                let sorted = array.sorted { (c1, c2) -> Bool in
                    return c1.name < c2.name
                }
                completion(sorted as? [T])
            case is Product.Type:
                let array = Array(json.values) as! [Product]
                let sortedArray = array.sorted { (p1, p2) -> Bool in
                    return p1.name < p2.name}
                completion(sortedArray as? [T])
    
            default:
                print("There is an error while decoding")
                completion(nil)
                
            }
            completion(nil)
            
        }
        .resume()
    }
}
