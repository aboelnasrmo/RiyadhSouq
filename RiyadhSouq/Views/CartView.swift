//
//  CartView.swift
//  RiyadhSouq
//
//  Created by Mohammad Aboelnasr on 04/04/2024.
//
import SwiftUI

struct CartView: View {
  @ObservedObject var cartViewModel: CartViewModel
  @State private var promoCode = ""
  @State private var discountApplied = false
  
  private var originalTotalPrice: Int {
    cartViewModel.items.reduce(0) { $0 + $1.price }
  }
  
  private var discountAmount: Int {
    discountApplied ? 50 : 0
  }
  
  private var discountedTotalPrice: Int {
    max(originalTotalPrice - (discountApplied ? 50 : 0), 0)
  }
  
  var body: some View {
    VStack {
      List {
        ForEach(cartViewModel.items, id: \.id) { item in
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
        .onDelete(perform: cartViewModel.removeFromCart)
      }
      
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
      
      HStack {
        Spacer()
        VStack(alignment: .trailing) {
          if discountApplied {
            Text("Original Price: $ \(originalTotalPrice)")
              .strikethrough()
              .font(.body)
              .fontWeight(.bold)
              .foregroundColor(.secondary)
            
            Text("Discount: $ \(discountAmount)")
              .font(.body)
              .fontWeight(.bold)
              .foregroundColor(.red)
          }
          Text("Total Price: $ \(discountedTotalPrice)")
            .font(.headline)
            .fontWeight(.bold)
        }
        .padding()
      }
    }
    .navigationTitle("Cart")
  }
}

struct CartView_Previews: PreviewProvider {
  static var previews: some View {
    CartView(cartViewModel: CartViewModel())
  }
}
