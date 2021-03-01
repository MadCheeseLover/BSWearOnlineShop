//
//  URLs.swift
//  BSWearOnlineShop
//
//  Created by Виктория Щербакова on 14.01.2021.
//

import Foundation

struct URLs {
    let categoryURL = "https://blackstarshop.ru/index.php?route=api/v1/categories"
    let productURL = "https://blackstarshop.ru/index.php?route=api/v1/products&cat_id="
    let blackStarURL = "https://blackstarshop.ru/"
    
    
    func getCatURL() -> URL? {
        guard let url = URL(string: categoryURL) else { return nil}
        return url
    }
    
    func getImageURL(imageUrlString: String) -> URL? {
        guard let url = URL(string: blackStarURL + imageUrlString) else { return nil }
        return url
    }
    
    func getProductURLFromID(subcategoryID: ID) -> URL? {
        guard let url = URL(string: productURL + subcategoryID.valueString()) else {
            return nil
        }
        return url
    }
}
