//
//  ProductRowView.swift
//  RiyadhSouq
//
//  Created by Mohammad Aboelnasr on 05/04/2024.
//

import SwiftUI

struct ProductRowView: View {
  var product: Product
  var body: some View {
    HStack {
      if let imageUrl = product.images.first, let url = URL(string: imageUrl) {
        AsyncImage(url: url) { image in
          image.resizable()
        } placeholder: {
          ProgressView()
        }
        .frame(width: 100, height: 100)
        .cornerRadius(8)
      }
      VStack(alignment: .leading) {
        Text(product.title)
          .font(.headline)
          .lineLimit(1)
        Text(product.description)
          .font(.subheadline)
          .lineLimit(2)
      }
    }
  }
}

#Preview {
    ProductRowView(product: Product(id: 0, title: "Product 1",
                                    price: 100, description: "Description 1",
                                    category: Category(id: 1, name: "",
                                                       image: ""), images: ["https://example.com/image1.jpg"]))
}
