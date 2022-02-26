//
//  ProductListViewModelTests.swift
//  DigitalShowroomTests
//
//  Created by Swati Sood on 30/01/2022.
//

import XCTest
import Combine
@testable import DigitalShowroom

class ProductListViewModelTests: XCTestCase {
    private var subscriptions = Set<AnyCancellable>()
    
    var viewModel: ProductListViewModel?

    override func setUpWithError() throws {
        viewModel = ProductListViewModel()
    }
    
    func testFetchVehicleDetails() {
        let expectation = expectation(description: "fetch expectation")
        viewModel?.$finishedLoading.sink(receiveValue: { [weak self] isFinished in
            guard isFinished != nil,
            let viewModel = self?.viewModel else {
                return
            }
            
            XCTAssertNil(viewModel.fetchProductsError)
            XCTAssertFalse(viewModel.products.isEmpty)
            expectation.fulfill()
        }).store(in: &subscriptions)
        
        viewModel?.fetchProducts()
        
        wait(for: [expectation], timeout: 5)
    }

}
