//
//  NetworkServicesProtocol.swift
//  DigitalShowroom
//
//  Created by Vikas Kharb on 30/01/2022.
//

import Foundation

protocol NetworkServicesProtocol {
    func getAllProducts(completion: @escaping ((Result<AllProductsResponse, NetworkRequestError>) -> Void))
    
    func getVinDetails(vinNumber: String, completion: @escaping ((Result<VinDetailsResponse, NetworkRequestError>) -> Void))
    
    func getCarLockStatus(vinNumber: String, completion: @escaping ((Result<CarLockStatusResponse, NetworkRequestError>) -> Void))
    
    func getDoorStatus(vinNumber: String, completion: @escaping ((Result<DoorsAndWindowsLockStatusResponse, NetworkRequestError>) -> Void))
}
