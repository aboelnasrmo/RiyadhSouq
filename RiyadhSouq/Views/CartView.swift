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
  @State private var discountAmount: Int = 0
  @State private var showInvalidPromoCodeAlert = false
  private var originalTotalPrice: Int {
    cartViewModel.items.reduce(0) { $0 + $1.price }
  }
  private var discountedTotalPrice: Int {
    max(originalTotalPrice - discountAmount, 0)
  }
  var body: some View {
    VStack {
      if cartViewModel.items.isEmpty {
        EmptyViewCart()
      } else {
        List {
          ForEach(cartViewModel.items, id: \.id) { item in
            CartItemRow(item: item)
          }
          .onDelete(perform: removeItems)
        }
        PromoCodeInput(promoCode: $promoCode,
                       discountAmount: $discountAmount,
                       showInvalidPromoCodeAlert: $showInvalidPromoCodeAlert,
                       cartViewModel: cartViewModel)
        TotalPriceView(originalTotalPrice: originalTotalPrice,
                       discountAmount: discountAmount,
                       discountedTotalPrice: discountedTotalPrice)
      }
    }
    .navigationTitle("Cart")
  }
  func removeItems(at offsets: IndexSet) {
    for index in offsets {
      let product = cartViewModel.items[index]
      cartViewModel.removeFromCart(product: product)
    }
  }
}

struct CartView_Previews: PreviewProvider {
  static var previews: some View {
    CartView(cartViewModel: CartViewModel())
  }
}

struct EmptyViewCart: View {
  var body: some View {
    Text("Your cart is empty, please add some items.")
      .font(.title2)
      .fontWeight(.medium)
      .foregroundColor(.secondary)
      .multilineTextAlignment(.center)
      .padding()
  }
}
