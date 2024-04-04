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
      VStack {
        // Image display logic
        if product.images.count > 1 {
          ScrollView(.horizontal, showsIndicators: false) {
            HStack {
              ForEach(product.images, id: \.self) { imageUrl in
                if let url = URL(string: imageUrl) {
                  AsyncImage(url: url) { image in
                    image.resizable()
                  } placeholder: {
                    ProgressView()
                  }
                  .frame(width: 300, height: 300)
                  .scaledToFit()
                  .cornerRadius(8)
                }
              }
            }
          }
        } else if let imageUrl = product.images.first, let url = URL(string: imageUrl) {
          AsyncImage(url: url) { image in
            image.resizable()
          } placeholder: {
            ProgressView()
          }
          .scaledToFit()
        }
        // Product details
        Text(product.title)
          .font(.title)
          .padding()
        Text(product.description)
          .font(.body)
          .padding()
        Text("Price: \(product.price)")
          .font(.headline)
          .padding()
      }
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
    }
    )
    .animation(.easeInOut, value: isInCart)
  }
}

struct ProductDetailView_Previews: PreviewProvider {
  static var previews: some View {
    ProductDetailView(product: .mock, cartViewModel: CartViewModel())
  }
}
