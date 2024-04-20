//
//  CartCalculationTest.swift
//  RiyadhSouqTests
//
//  Created by Mohammad Aboelnasr on 18/04/2024.
//

import XCTest
@testable import RiyadhSouq

class CartViewModelTests: XCTestCase {
    var viewModel: CartViewModel!
    let mockProduct = Product(id: 0, title: "Product 1",
                              price: 100, description: "Description 1",
                              category: Category(id: 1, name: "",
                                                 image: ""), images: ["https://example.com/image1.jpg"])

    override func setUp() {
        super.setUp()
        viewModel = CartViewModel()
        viewModel.items = []
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testAddToCart() {
        viewModel.addToCart(mockProduct)
        XCTAssertTrue(viewModel.items.contains(where: { $0.id == mockProduct.id }),
                      "Product should be added to the cart")
    }

    func testRemoveFromCart() {
        viewModel.addToCart(mockProduct)
        viewModel.removeFromCart(product: mockProduct)
        XCTAssertFalse(viewModel.items.contains(where: { $0.id == mockProduct.id }),
                       "Product should be removed from the cart")
    }

    func testApplyPromoCode() {
        viewModel.items = [mockProduct]
        let discount = viewModel.applyPromoCode("save50") // "save50": 50, "summer": 30, "school": 40
        XCTAssertEqual(discount, 50, "Promo code should apply the correct discount")
    }

    func testIsProductInCart() {
        viewModel.addToCart(mockProduct)
        XCTAssertTrue(viewModel.isProductInCart(mockProduct), "Product should be recognized as in the cart")
    }

    func testApplyNonexistentPromoCode() {
        let discount = viewModel.applyPromoCode("fakecode")
        XCTAssertEqual(discount, 0, "Nonexistent promo codes should return a discount of 0")
    }
}
