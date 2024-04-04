//
//  ProductsView.swift
//  RiyadhSouq
//
//  Created by Mohammad Aboelnasr on 04/04/2024.
//

import SwiftUI

struct ProductRowView: View {
  var product: Product
  var body: some View {
    HStack {
      // Display the product image
      if let imageUrl = product.images.first, let url = URL(string: imageUrl) {
        AsyncImage(url: url) { image in
          image.resizable()
        } placeholder: {
          ProgressView()
        }
        .frame(width: 100, height: 100)
        .cornerRadius(8)
      }
      // Display title and description
      VStack(alignment: .leading) {
        Text(product.title)
          .font(.headline)
          .lineLimit(1) // Truncate the title to one line
        Text(product.description)
          .font(.subheadline)
          .lineLimit(2) // Truncate the description to two lines
      }
    }
  }
}

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
