//
//  SplashScreenView.swift
//  RiyadhSouq
//
//  Created by Mohammad Aboelnasr on 05/04/2024.
//

import SwiftUI

struct SplashScreenView: View {
  @State private var isActive = false
  @State private var isAnimating = false
  @StateObject var viewModel = ProductsViewModel()
  var cartViewModel: CartViewModel
  var body: some View {
    VStack {
      if isActive {
        MainTabView()
      } else {
        Image("Market")
          .resizable()
          .scaledToFill()
          .opacity(isAnimating ? 1 : 0)
          .scaleEffect(isAnimating ? 1 : 0.9)
          .onAppear {
            withAnimation(.easeOut(duration: 2.0)) {
              isAnimating = true
            }
          }
      }
    }
    .onAppear {
      Task {
        await   viewModel.loadProducts()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
          withAnimation {
            isActive = true
          }
        }
      }
    }
    .edgesIgnoringSafeArea(.all)
  }
}

struct SplashScreenView_Previews: PreviewProvider {
  static var previews: some View {
    SplashScreenView( cartViewModel: CartViewModel())
  }
}
