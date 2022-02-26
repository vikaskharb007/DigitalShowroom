//
//  LockStatusViewTests.swift
//  DigitalShowroomTests
//
//  Created by Vikas Kharb on 30/01/2022.
//

import XCTest
@testable import DigitalShowroom

class LockStatusViewTests: XCTestCase {
    
    let lockStatusView = LockStatusView( openText: "Close", closeText: "Open")

    func testToggleChange()  {
        lockStatusView.isClosed = false
        XCTAssertEqual(lockStatusView.statusLabel.text, "Close")
        
        // Click Button
        lockStatusView.buttonClicked()
        
        XCTAssertEqual(lockStatusView.statusLabel.text, "Open")
        XCTAssertTrue(lockStatusView.isClosed)
    }

}
