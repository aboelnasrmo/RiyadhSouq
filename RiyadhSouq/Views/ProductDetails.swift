//
//  ProductDetails.swift
//  RiyadhSouq
//
//  Created by Mohammad Aboelnasr on 05/04/2024.
//

import SwiftUI

struct ProductDetails: View {
  let product: Product
  var body: some View {
    VStack {
      HStack {
        Text("ID: \(product.id)")
          .font(.subheadline)
          .bold()
          .padding()
        Text(product.title)
          .font(.subheadline)
          .bold()
        .padding()
        Spacer()
      }
      HStack {
        Spacer()
        Text("Price: $ \(product.price)")
          .font(.headline)
          .padding()
      }
      Text(product.description)
        .font(.body)
        .padding()
    }
  }
}

struct ProductDetails_Previews: PreviewProvider {
  static var previews: some View {
    ProductDetails(product: Product(id: 0, title: "Product 1",
                                    price: 100, description: "Description 1",
                                    category: Category(id: 1, name: "",
                                                       image: ""), images: ["https://example.com/image1.jpg"]))
    .previewLayout(.sizeThatFits)
  }
}
