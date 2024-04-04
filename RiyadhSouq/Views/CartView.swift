//
//  CartView.swift
//  RiyadhSouq
//
//  Created by Mohammad Aboelnasr on 04/04/2024.
//

import SwiftUI

struct CartView: View {
  var cartItems: [Product]
  @State private var promoCode = ""
  @State private var discountApplied = false
  
  private var originalTotalPrice: Int {
    cartItems.reduce(0) { $0 + $1.price }
  }
  
  private var discountedTotalPrice: Int {
    max(originalTotalPrice - (discountApplied ? 50 : 0), 0)
  }
  
  private var totalPrice: Int {
    cartItems.reduce(0) { $0 + $1.price }
  }
  
  var body: some View {
    VStack {
      List(cartItems, id: \.id) { item in
        HStack {
          // Image
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
            Text("Price: \(item.price)")
              .font(.subheadline)
          }
        }
      }
      
      // Promo code section
      HStack {
        TextField("Enter promo code", text: $promoCode)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .padding()
        
        Button("Apply") {
          if promoCode.lowercased() == "now" && !discountApplied {
            discountApplied = true
          }
        }
        .padding()
      }
      
      // Total Price
      VStack(alignment: .trailing) {
        if discountApplied {
          Text("Original Price: \(originalTotalPrice)")
            .strikethrough()
            .font(.body)
            .fontWeight(.bold)
            .foregroundColor(.secondary)
        }
        Text("Total Price: \(discountedTotalPrice)")
          .font(.headline)
          .fontWeight(.bold)
      }
      .padding()
    }
    .navigationTitle("Cart")
  }
}

struct CartView_Previews: PreviewProvider {
  static var previews: some View {
    CartView(cartItems: [Product.mock])
  }
}
