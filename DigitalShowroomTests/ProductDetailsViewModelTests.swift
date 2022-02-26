//
//  ProductDetailsViewModelTests.swift
//  DigitalShowroomTests
//
//  Created by Vikas Kharb on 30/01/2022.
//

import XCTest
import Combine
@testable import DigitalShowroom

class ProductDetailsViewModelTests: XCTestCase {
    private var subscriptions = Set<AnyCancellable>()
    
    var viewModel: ProductDetailsViewModel?

    override func setUpWithError() throws {
        let product = ProductListModel(vin: "C7DD802C-F2B6-409F-A981-7BC10F9DCE08", licensePlate: "sample", imageURL: "")
        viewModel = ProductDetailsViewModel(productData: product)
    }
    
    func testFetchVehicleDetails() {
        let expectation = expectation(description: "fetch expectation")
        viewModel?.$vehichleDetailsFetched.sink(receiveValue: { isFinished in
            guard isFinished != nil else {
                return
            }
            XCTAssertNotNil(self.viewModel?.vehicleCompleteDetails)
            expectation.fulfill()
        }).store(in: &subscriptions)
        viewModel?.getVehicleDetails()
        
        wait(for: [expectation], timeout: 5)
    }

}
