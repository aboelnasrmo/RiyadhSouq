//
//  ProductsView.swift
//  RiyadhSouq
//
//  Created by Mohammad Aboelnasr on 04/04/2024.
//

import SwiftUI

struct ProductsView: View {
  @StateObject var viewModel = ProductsViewModel()
  var cartViewModel: CartViewModel
  @State private var selectedSortCriteria: ProductsViewModel.SortCriteria = .id
  @State private var searchText = ""
  var body: some View {
    NavigationStack {
      ProductListView(products: filteredProducts(), cartViewModel: cartViewModel)
        .navigationTitle("Products")
        .navigationBarItems(trailing: sortPicker)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        .onChange(of: selectedSortCriteria) { newValue in
          viewModel.sortProducts(by: newValue)
        }
        .refreshable {
          await viewModel.loadProducts()
        }
    }
  }
  var sortPicker: some View {
    Menu {
      Picker("Sort By", selection: $selectedSortCriteria) {
        Text("ID").tag(ProductsViewModel.SortCriteria.id)
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
  func filteredProducts() -> [Product] {
    if searchText.isEmpty {
      return viewModel.products
    } else {
      return viewModel.products.filter { product in
        product.title.lowercased().contains(searchText.lowercased()) ||
        product.description.lowercased().contains(searchText.lowercased())
      }
    }
  }
}

struct ProductListView: View {
  var products: [Product]
  var cartViewModel: CartViewModel
  var body: some View {
    List(products) { product in
      NavigationLink(destination: ProductDetailView(product: product, cartViewModel: cartViewModel)) {
        ProductRowView(product: product)
      }
    }
  }
}

struct ProductsView_Previews: PreviewProvider {
  static var previews: some View {
    ProductsView(cartViewModel: CartViewModel())
  }
}
