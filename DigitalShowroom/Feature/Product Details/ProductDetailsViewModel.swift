//
//  ProductDetailsViewModel.swift
//  DigitalShowroom
//
//  Created by Vikas Kharb on 30/01/2022.
//

import UIKit

struct ProductDetailsModel {
    var licencePlateNumber: String
    var isCarLocked: Bool
    var isFrontRightDoorLocked: Bool
    var isFrontLeftDoorLocked: Bool
    var isPassengerRightDoorLocked: Bool
    var isPassengerLeftDoorLocked: Bool
}

class ProductDetailsViewModel: ObservableObject {
    var productDetails: ProductListModel
    
    @Published var vehichleDetailsFetched: Bool?
    @Published var vehicleCompleteDetails: ProductDetailsModel?
    @Published var carLockFetchError: NetworkRequestError?
    @Published var doorDetailsFetchError: NetworkRequestError?
    
    let manager: NetworkServicesProtocol
    
    init(productData: ProductListModel, manager: NetworkServicesProtocol = NetworkManager.shared) {
        self.productDetails = productData
        self.manager = manager
    }
    
    func getVehicleDetails() {
        var isCarLocked = false
        var doorDetails: DoorsAndWindowsLockStatusResponse?
        
        let group = DispatchGroup()
        
        group.enter()
        manager.getCarLockStatus(vinNumber: productDetails.vin) { [weak self] result in

            switch result {
            case .success(let lockResponse):
                isCarLocked = lockResponse.locked
                
            case .failure(let error):
                self?.carLockFetchError = error
            }
            
            group.leave()
        }
        
        group.enter()
        manager.getDoorStatus(vinNumber: productDetails.vin) { [weak self] result in
            switch result {
            case .success(let response):
                print(response)
                doorDetails = response

            case .failure(let error):
                self?.doorDetailsFetchError = error
            }

            group.leave()
        }
        
        group.notify(queue: .main) {
            
            guard let doorDetails = doorDetails else {
                self.doorDetailsFetchError = NetworkRequestError.genericError("Data Error")
                self.vehichleDetailsFetched = true
                return
            }
            let frontLeftStatus: Bool = doorDetails.doorLeftFront == "closed"
            let frontRightStatus: Bool = doorDetails.doorRightFront == "closed"
            let passengerRightStatus: Bool = doorDetails.doorRightBack == "closed"
            let passengerLeftStatus: Bool = doorDetails.doorLeftBack == "closed"
            
            self.vehicleCompleteDetails = ProductDetailsModel(licencePlateNumber: self.productDetails.licensePlate, isCarLocked: isCarLocked, isFrontRightDoorLocked: frontRightStatus, isFrontLeftDoorLocked: frontLeftStatus, isPassengerRightDoorLocked: passengerRightStatus, isPassengerLeftDoorLocked: passengerLeftStatus)
            self.vehichleDetailsFetched = true
            
        }
    }
}
