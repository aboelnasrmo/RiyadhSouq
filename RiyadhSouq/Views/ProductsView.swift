//
//  ProductsView.swift
//  RiyadhSouq
//
//  Created by Mohammad Aboelnasr on 04/04/2024.
//

import SwiftUI

struct ProductsView: View {
  @ObservedObject var viewModel = ProductsViewModel()
  var cartViewModel: CartViewModel
  @State private var selectedSortCriteria: ProductsViewModel.SortCriteria = .name
  var body: some View {
    NavigationStack {
      List(viewModel.products) { product in
        NavigationLink(destination: ProductDetailView(product: product, cartViewModel: cartViewModel)) {
          ProductRowView(product: product)
        }
      }
      .navigationTitle("Products")
      .navigationBarItems(trailing: sortPicker)
    }
    .onAppear {
      viewModel.loadProducts()
    }
    .onChange(of: selectedSortCriteria, initial: .random()) { newValue, _ in
      viewModel.sortProducts(by: newValue)
    }
  }
  var sortPicker: some View {
    Menu {
      Picker("Sort By", selection: $selectedSortCriteria) {
        Text("Name").tag(ProductsViewModel.SortCriteria.name)
        Text("Price").tag(ProductsViewModel.SortCriteria.price)
        Text("Category").tag(ProductsViewModel.SortCriteria.category)
      }
    } label: {
      Label("Sort By", systemImage: "arrow.up.arrow.down")
        .labelStyle(IconOnlyLabelStyle())
        .imageScale(.small)
    }
  }
}

struct ProductsView_Previews: PreviewProvider {
  static var previews: some View {
    ProductsView(cartViewModel: CartViewModel())
  }
}
