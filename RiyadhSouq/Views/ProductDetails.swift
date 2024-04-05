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
      Text(product.title)
        .font(.title)
        .padding()
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
