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
      List {
        ForEach(cartViewModel.items, id: \.id) { item in
          CartItemRow(item: item)
        }
        .onDelete(perform: cartViewModel.removeFromCart)
      }
      PromoCodeInput(promoCode: $promoCode,
                     discountAmount: $discountAmount,
                     showInvalidPromoCodeAlert: $showInvalidPromoCodeAlert, cartViewModel: cartViewModel)
      TotalPriceView(originalTotalPrice: originalTotalPrice,
                     discountAmount: discountAmount,
                     discountedTotalPrice: discountedTotalPrice)
    }
    .navigationTitle("Cart")
  }
}

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

struct PromoCodeInput: View {
  @Binding var promoCode: String
  @Binding var discountAmount: Int
  @Binding var showInvalidPromoCodeAlert: Bool
  var cartViewModel: CartViewModel
  var body: some View {
    HStack {
      TextField("Enter promo code", text: $promoCode)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
      Button("Apply") {
        if promoCode.isEmpty {
          discountAmount = 0
        } else {
          let discount = cartViewModel.applyPromoCode(promoCode)
          if discount > 0 {
            discountAmount = discount
          } else {
            discountAmount = 0
            showInvalidPromoCodeAlert = true
          }
        }
      }
      .padding()
    }
    .alert(isPresented: $showInvalidPromoCodeAlert) {
      Alert(title: Text("Invalid Promo Code"),
            message: Text("The promo code you entered is not valid."),
            dismissButton: .default(Text("OK")))
    }
  }
}

struct TotalPriceView: View {
  let originalTotalPrice: Int
  let discountAmount: Int
  let discountedTotalPrice: Int
  var body: some View {
    HStack {
      Spacer()
      VStack(alignment: .trailing) {
        if discountAmount > 0 {
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
}

struct CartView_Previews: PreviewProvider {
  static var previews: some View {
    CartView(cartViewModel: CartViewModel())
  }
}
