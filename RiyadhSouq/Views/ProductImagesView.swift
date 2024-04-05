//
//  ProductImagesView.swift
//  RiyadhSouq
//
//  Created by Mohammad Aboelnasr on 05/04/2024.
//

import SwiftUI

struct ProductImagesView: View {
  let images: [String]
  var body: some View {
    if images.count > 1 {
      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          ForEach(images, id: \.self) { imageUrl in
            if let url = URL(string: imageUrl) {
              AsyncImage(url: url) { image in
                image.resizable()
              } placeholder: {
                ProgressView()
              }
              .frame(width: 300, height: 300)
              .scaledToFit()
              .cornerRadius(8)
            }
          }
        }
      }
    } else if let imageUrl = images.first, let url = URL(string: imageUrl) {
      AsyncImage(url: url) { image in
        image.resizable()
      } placeholder: {
        ProgressView()
      }
      .scaledToFit()
    }
  }
}

struct ProductImagesView_Previews: PreviewProvider {
  static var previews: some View {
    ProductImagesView(images: ["https://example.com/image1.jpg",
                               "https://example.com/image2.jpg",
                               "https://example.com/image3.jpg"])
  }
}
