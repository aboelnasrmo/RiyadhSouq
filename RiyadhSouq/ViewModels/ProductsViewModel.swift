//
//  ProductsViewModel.swift
//  RiyadhSouq
//
//  Created by Mohammad Aboelnasr on 04/04/2024.
//

import Foundation

@MainActor
class ProductsViewModel: ObservableObject {
    @Published var products: [Product] = []
  
  init() {
         loadProducts()
     }

    func loadProducts() {
        // Check if the products have been loaded before
        if UserDefaults.standard.bool(forKey: "hasLoadedProductsOnce") {
            // Load from cache
            loadProductsFromCache()
        } else {
            // Load from API and set the flag
            loadProductsFromAPI()
            UserDefaults.standard.set(true, forKey: "hasLoadedProductsOnce")
        }
    }

    private func loadProductsFromAPI() {
        Task {
            do {
                let fetchedProducts = try await APIService.shared.fetchProducts()
                self.products = fetchedProducts
                try CacheManager.shared.saveToCache(products: fetchedProducts)
            } catch {
                loadProductsFromCache()
            }
        }
    }

    private func loadProductsFromCache() {
        Task {
            do {
                self.products = try CacheManager.shared.loadFromCache()
            } catch {
                print("Error loading from cache: \(error)")
            }
        }
    }
}
