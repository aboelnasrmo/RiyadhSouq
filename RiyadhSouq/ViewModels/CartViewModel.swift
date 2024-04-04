//
//  CartViewModel.swift
//  RiyadhSouq
//
//  Created by Mohammad Aboelnasr on 05/04/2024.
//

import Foundation

class CartViewModel: ObservableObject {
    @Published var items: [Product] = []
    
    func addToCart(_ product: Product) {
        if !isProductInCart(product) {
            items.append(product)
        }
    }

    func isProductInCart(_ product: Product) -> Bool {
        items.contains(where: { $0.id == product.id })
    }
}
