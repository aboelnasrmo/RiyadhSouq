//
//  CartViewModel.swift
//  RiyadhSouq
//
//  Created by Mohammad Aboelnasr on 05/04/2024.
//

import Foundation

class CartViewModel: ObservableObject {
  @Published var items: [Product] = []
  
  init() {
    loadCartItems()
  }
  
  
  func addToCart(_ product: Product) {
    if !isProductInCart(product) {
      items.append(product)
      saveCartItems()
    }
  }
  
  func removeFromCart(at offsets: IndexSet) {
         items.remove(atOffsets: offsets)
    saveCartItems()
     }
  
  func isProductInCart(_ product: Product) -> Bool {
    items.contains(where: { $0.id == product.id })
  }
  private func saveCartItems() {
    do {
      let data = try JSONEncoder().encode(items)
      let fileURL = getDocumentsDirectory().appendingPathComponent("cartItems.json")
      try data.write(to: fileURL)
    } catch {
      print("Failed to save cart items: \(error)")
    }
  }
  
  private func loadCartItems() {
    let fileURL = getDocumentsDirectory().appendingPathComponent("cartItems.json")
    do {
      let data = try Data(contentsOf: fileURL)
      items = try JSONDecoder().decode([Product].self, from: data)
    } catch {
      print("Failed to load cart items: \(error)")
    }
  }
  
  private func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
}
