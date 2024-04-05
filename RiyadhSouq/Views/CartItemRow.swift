//
//  CartItemRow.swift
//  RiyadhSouq
//
//  Created by Mohammad Aboelnasr on 05/04/2024.
//

import SwiftUI

struct CartItemRow: View {
  let item: Product // Assuming Product is your data model
  var body: some View {
    HStack {
      if let imageUrl = item.images.first, let url = URL(string: imageUrl) {
        AsyncImage(url: url) { image in
          image.resizable()
        } placeholder: {
          ProgressView()
        }
        .frame(width: 60, height: 60)
        .cornerRadius(8)
      }
      VStack(alignment: .leading) {
        Text(item.title)
          .font(.headline)
        Text("Price: $ \(item.price)")
          .font(.subheadline)
      }
    }
  }
}

struct CartItemRow_Previews: PreviewProvider {
    static var previews: some View {
      CartItemRow(item: Product(id: 0, title: "Product 1",
                                price: 100, description: "Description 1",
                                category: Category(id: 1, name: "",
                                                   image: ""), images: ["https://example.com/image1.jpg"]))
            .previewLayout(.sizeThatFits)
    }
}
