//
//  Products.swift
//  RiyadhSouq
//
//  Created by Mohammad Aboelnasr on 04/04/2024.
//

import Foundation

// Define a struct for the Category
struct Category: Codable , Identifiable,Hashable{
    var id: Int
    var name: String
    var image: String
}

// Define a struct for the Product
struct Product: Codable,Identifiable,Hashable {
    var id: Int
    var title: String
    var price: Int
    var description: String
    var category: Category
    var images: [String]
}

// Define a type for an array of Products, for easy decoding
typealias ProductList = [Product]

extension Product {
    static var mock: Product {
        Product(
            id: 1,
            title: "Sample Product",
            price: 99,
            description: "This is a sample product description.",
            category: Category(id: 1, name: "Sample Category", image: "https://example.com/image.jpg"),
            images: ["https://example.com/image.jpg"]
        )
    }
}
