//
//  ProductsView.swift
//  RiyadhSouq
//
//  Created by Mohammad Aboelnasr on 04/04/2024.
//

import SwiftUI

struct ProductsView: View {
  @ObservedObject var viewModel = ProductsViewModel()
  var cartViewModel: CartViewModel
  @State private var selectedProduct: Product?
  var body: some View {
    NavigationStack {
      List(viewModel.products) { product in
        NavigationLink(destination: ProductDetailView(product: product, cartViewModel: cartViewModel)) {
          ProductRowView(product: product)
        }
      }
      .navigationTitle("Products")
    }
    .onAppear {
      viewModel.loadProducts()
    }
  }
}

struct ProductsView_Previews: PreviewProvider {
  static var previews: some View {
    ProductsView(cartViewModel: CartViewModel())
  }
}
