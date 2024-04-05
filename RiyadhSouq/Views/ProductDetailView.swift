//
//  ProductDetailView.swift
//  RiyadhSouq
//
//  Created by Mohammad Aboelnasr on 05/04/2024.
//

import SwiftUI

struct ProductDetailView: View {
  var product: Product
  @ObservedObject var cartViewModel: CartViewModel
  private var isInCart: Bool {
    cartViewModel.isProductInCart(product)
}
  var body: some View {
    ScrollView {
      ProductImagesView(images: product.images)
      ProductDetails(product: product)
    }
    .navigationTitle(product.title)
    .navigationBarItems(trailing: Button {
      DispatchQueue.main.async {
        if !isInCart {
          cartViewModel.addToCart(product)
        }
      }
    } label: {
      Image(systemName: "cart.badge.plus")
        .foregroundColor(isInCart ? .blue : .primary)
        .scaleEffect(isInCart ? 1.5 : 1.0)
    })
    .animation(.easeInOut, value: isInCart)
  }
}

struct ProductDetailView_Previews: PreviewProvider {
  static var previews: some View {
    ProductDetailView(product: .mock, cartViewModel: CartViewModel())
  }
}
