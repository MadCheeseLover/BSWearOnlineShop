//
//  Product.swift
//  BSWearOnlineShop
//
//  Created by Виктория Щербакова on 14.01.2021.
//

import Foundation

struct Product: Decodable {
    var name, description, mainImage, price : String
    var sortOrder: ID
    var productImages: [WearImage]
    var offers : [Offers]
    var colorName: String
}

struct WearImage: Decodable {
    var imageURL, sortOrder: String
}

struct Offers: Decodable {
    var size : String
}

struct WearWithOffer {
    var item: Product
    var offer: String
}



