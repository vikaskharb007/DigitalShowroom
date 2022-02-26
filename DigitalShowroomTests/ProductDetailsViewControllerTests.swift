//
//  ProductDetailsViewControllerTests.swift
//  DigitalShowroomTests
//
//  Created by Vikas Kharb on 30/01/2022.
//

import XCTest
import Combine
@testable import DigitalShowroom

class ProductDetailsViewControllerTests: XCTestCase {
    
    var controller: ProductDetailsViewController?
    private var subscriptions: Set<AnyCancellable> = []
    
    override func setUpWithError() throws {
        let viewModel = ProductDetailsViewModel(productData: ProductListModel(vin: "", licensePlate: "", imageURL: ""), manager: MockNetworkManager.shared)
        controller = ProductDetailsViewController(viewModel: viewModel)
    }
    
    func testElementsUpdate() throws {
        controller?.viewWillAppear(true)
        
        controller?.viewModel.$vehichleDetailsFetched.sink(receiveValue: { [weak self] isfinished in
            guard let finished = isfinished,
            let controller = self?.controller
            else {
                return
            }
            
            XCTAssertTrue(finished)
            XCTAssertTrue(controller.carStatusRow.lockView.isClosed)
            XCTAssertFalse(controller.frontLeftDoorRow.lockView.isClosed)
            XCTAssertTrue(controller.frontRightDoorRow.lockView.isClosed)
            XCTAssertTrue(controller.passengerLeftDoorRow.lockView.isClosed)
            XCTAssertTrue(controller.passengerRightDoorRow.lockView.isClosed)
        }).store(in: &subscriptions)
    }
}
