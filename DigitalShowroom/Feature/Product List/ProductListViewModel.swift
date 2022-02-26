//
//  ProductListViewModel.swift
//  DigitalShowroom
//
//  Created by Vikas Kharb on 30/01/2022.
//

import Foundation

struct ProductListModel {
    var vin: String
    var licensePlate: String
    var imageURL: String
}

class ProductListViewModel: ObservableObject {
    let manager: NetworkServicesProtocol
    
    var products = [ProductListModel]()
    @Published var finishedLoading: Bool?
    @Published var fetchProductsError: NetworkRequestError?
    
    init(networkManager: NetworkServicesProtocol = NetworkManager.shared) {
        manager = networkManager
    }
    
    func fetchProducts() {
        manager.getAllProducts { [weak self] result in
            switch result {
                
            case .success(let products):
                print(products.vins)
                self?.fetchVinDetails(vinNumbers: products.vins)
            case .failure(let error):
                self?.fetchProductsError = error
                print(error.title)
            }
        }
    }
    
    func fetchVinDetails(vinNumbers: [String]) {
        let group = DispatchGroup()
        
        vinNumbers.forEach { vin in
            group.enter()
            
            manager.getVinDetails(vinNumber: vin) { result in
                switch result {
                case .success(let details):
                    let vehicle = ProductListModel(vin: vin, licensePlate: details.plate, imageURL: details.imagePath)
                    self.products.append(vehicle)
                    
                case .failure(let error):
                    // Faulty downloads are being skipped. Alternatively list can be appended with a placeholder product which can be recognized in the view and a redownload option for the product can be made available on the view.
                    print(error.title)
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.finishedLoading = true
        }
        
    }
}
