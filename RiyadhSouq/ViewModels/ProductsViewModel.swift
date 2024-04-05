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
  enum SortCriteria {
    case id
    case name
    case price
    case category
  }
  init() {
    loadProducts()
  }
  func sortProducts(by criteria: SortCriteria) {
    switch criteria {
    case .id:
        products.sort { $0.id < $1.id }
    case .name:
        products.sort { $0.title.localizedCompare($1.title) == .orderedAscending }
    case .price:
        products.sort { $0.price < $1.price }
    case .category:
        products.sort { $0.category.name < $1.category.name }
    }
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
