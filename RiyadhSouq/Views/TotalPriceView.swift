//
//  TotalPriceView.swift
//  RiyadhSouq
//
//  Created by Mohammad Aboelnasr on 05/04/2024.
//

import SwiftUI

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

struct TotalPriceView_Previews: PreviewProvider {
    static var previews: some View {
        TotalPriceView(
            originalTotalPrice: 100,
            discountAmount: 20,
            discountedTotalPrice: 80
        )
        .previewLayout(.sizeThatFits)
    }
}
