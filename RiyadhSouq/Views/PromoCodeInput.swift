//
//  PromoCodeInput.swift
//  RiyadhSouq
//
//  Created by Mohammad Aboelnasr on 05/04/2024.
//

import SwiftUI

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

struct PromoCodeInput_Previews: PreviewProvider {
  @State static var promoCode = ""
  @State static var discountAmount = 0
  @State static var showInvalidPromoCodeAlert = false
  static var previews: some View {
    PromoCodeInput(
      promoCode: $promoCode,
      discountAmount: $discountAmount,
      showInvalidPromoCodeAlert: $showInvalidPromoCodeAlert,
      cartViewModel: DummyCartViewModel()
    )
  }
}

class DummyCartViewModel: CartViewModel {
  override init() {
    super.init()
  }
  override func applyPromoCode(_ code: String) -> Int {
    return code == "DISCOUNT" ? 10 : 0
  }
}
