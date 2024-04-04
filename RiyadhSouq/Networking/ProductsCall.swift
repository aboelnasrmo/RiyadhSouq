//
//  ProductsCall.swift
//  RiyadhSouq
//
//  Created by Mohammad Aboelnasr on 04/04/2024.
//

import Foundation

class APIService {
    static let shared = APIService()
    private init() {}

    private let url = URL(string: "https://api.escuelajs.co/api/v1/products")!

    func fetchProducts() async throws -> [Product] {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Product].self, from: data)
    }
}

class CacheManager {
    static let shared = CacheManager()
    private init() {}

    private var cacheURL: URL {
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return directory.appendingPathComponent("products.json")
    }

    func saveToCache(products: [Product]) throws {
        let data = try JSONEncoder().encode(products)
        try data.write(to: cacheURL)
    }

    func loadFromCache() throws -> [Product] {
        let data = try Data(contentsOf: cacheURL)
        return try JSONDecoder().decode([Product].self, from: data)
    }
}

