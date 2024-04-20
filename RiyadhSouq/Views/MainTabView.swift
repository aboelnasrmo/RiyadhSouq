//
//  MainTabView.swift
//  RiyadhSouq
//
//  Created by Mohammad Aboelnasr on 04/04/2024.
//

import SwiftUI

struct MainTabView: View {
  @StateObject var cartViewModel = CartViewModel()
  var body: some View {
    TabView {
      ProductsView(cartViewModel: cartViewModel)
        .tabItem {
          Label("Products", systemImage: "list.dash")
        }
      CartView(cartViewModel: cartViewModel)
        .tabItem {
          Label("Cart", systemImage: cartViewModel.items.count == 0 ? "cart" : "cart.circle.fill")
        }
        .badge(cartViewModel.items.count)
    }
  }
}

#Preview {
  MainTabView()
}
