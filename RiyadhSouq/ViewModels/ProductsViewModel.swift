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
  @Published var isLoading: Bool = false
  @Published var errorMessage: String?
  enum SortCriteria {
    case id, name, price, category
  }
  init() {
    Task {
      await loadProducts()
    }
  }
  func sortProducts(by criteria: SortCriteria) {
    products.sort {
      switch criteria {
      case .id:
          return $0.id < $1.id
      case .name:
          return $0.title.localizedCompare($1.title) == .orderedAscending
      case .price:
          return $0.price < $1.price
      case .category:
          return $0.category.name < $1.category.name
      }
    }
  }
  func loadProducts() async {
    isLoading = true
    if UserDefaults.standard.bool(forKey: "hasLoadedProductsOnce") {
      await loadProductsFromCache()
    } else {
      await loadProductsFromAPI()
    }
    isLoading = false
  }
  private func loadProductsFromAPI() async {
    do {
      let fetchedProducts = try await APIService.shared.fetchProducts()
      if !fetchedProducts.isEmpty {
        self.products = fetchedProducts
        try CacheManager.shared.saveToCache(products: fetchedProducts)
        UserDefaults.standard.set(true, forKey: "hasLoadedProductsOnce")
      } else {
        errorMessage = "No products found on the server."
        await loadProductsFromCache()
      }
    } catch {
      errorMessage = "Failed to fetch products. Please check your internet connection."
      await loadProductsFromCache()
    }
}
  private func loadProductsFromCache() async {
    do {
      let cachedProducts = try CacheManager.shared.loadFromCache()
      if cachedProducts.isEmpty {
        errorMessage = "No products available in cache. Please refresh."
      } else {
        self.products = cachedProducts
      }
    } catch {
      errorMessage = "Error loading products from cache: \(error.localizedDescription)"
    }
  }
}
