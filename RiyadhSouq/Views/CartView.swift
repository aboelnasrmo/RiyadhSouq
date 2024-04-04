//
//  CartView.swift
//  RiyadhSouq
//
//  Created by Mohammad Aboelnasr on 04/04/2024.
//

import SwiftUI

struct CartView: View {
    var cartItems: [Product]

    var body: some View {
        List(cartItems, id: \.id) { item in
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                // Add more details as needed
            }
        }
        .navigationTitle("Cart")
    }
}



struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(cartItems: [Product.mock])
    }
}
