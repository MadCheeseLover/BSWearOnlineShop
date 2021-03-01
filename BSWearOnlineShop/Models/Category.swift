//
//  Category.swift
//  BSWearOnlineShop
//
//  Created by Виктория Щербакова on 14.01.2021.
//

import Foundation


// MARK: - CategoriesValue
struct Categories: Codable {
    let name: String
    let sortOrder: ID
    let image, iconImage, iconImageActive: String
    let subcategories: [Subcategory]
}

enum ID: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(ID.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for SortOrder"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
    func valueString() -> String {
        switch self {
        case .string(let value) :
            return value
        case .integer(let value) :
            return String(value)
        }
    }
    func valueInt() -> Int {
        switch self {
        case .integer(let value):
            return value
        case .string(let value):
            return Int(value)!
        }
    }
}

// MARK: - Subcategory
struct Subcategory: Codable {
    let id: ID
    let iconImage: String
    let sortOrder: ID
    let name: String
    let type: TypeEnum
}

enum TypeEnum: String, Codable {
    case category = "Category"
    case collection = "Collection"
}

//typealias Categories = [String: CategoriesValue]
