//
//  ProductListViewControllerTests.swift
//  DigitalShowroomTests
//
//  Created by Vikas Kharb on 30/01/2022.
//

import XCTest
import Combine
@testable import DigitalShowroom

class ProductListViewControllerTests: XCTestCase {

    
    var controller: ProductListViewController?
    private var subscriptions: Set<AnyCancellable> = []
    
    override func setUpWithError() throws {
        let viewModel = ProductListViewModel(networkManager: MockNetworkManager.shared)
        controller = ProductListViewController(viewModel: viewModel)
    }
    
    func testElementsUpdate() throws {
        controller?.viewWillAppear(true)
        
        controller?.viewModel.$finishedLoading.sink(receiveValue: { [weak self] isfinished in
            guard let finished = isfinished,
            let controller = self?.controller
            else {
                return
            }
            
            XCTAssertTrue(finished)
            XCTAssertEqual(controller.viewModel.products.count, 3)
        }).store(in: &subscriptions)
    }

}
