//
//  NetworkManager.swift
//  DigitalShowroom
//
//  Created by Vikas Kharb on 30/01/2022.
//

import Foundation

class NetworkManager: NetworkServicesProtocol {
    static let shared = NetworkManager()
    
    private init() {}
    
    // MARK: - API requests
    
    func getAllProducts(completion: @escaping ((Result<AllProductsResponse, NetworkRequestError>) -> Void))  {
        NetworkRequest<AllProductsResponse>(request: .cars).execute { result in
            switch result {
                
            case .success(let productList):
                completion(.success(productList))
                
            case .failure(let error):
                if let networkRequestErr = error as? NetworkRequestError {
                    completion(.failure(networkRequestErr))
                } else {
                    let nserror = error as NSError
                    
                    // Individual errors can be handled
                    if nserror.code == 403 {
                        completion(.failure(NetworkRequestError.sessionExpired))
                    } else {
                        completion(.failure(.apiError(error.localizedDescription)))
                    }
                }
            }
        }
    }
    
    func getVinDetails(vinNumber: String, completion: @escaping ((Result<VinDetailsResponse, NetworkRequestError>) -> Void)) {
        NetworkRequest<VinDetailsResponse>.init(request: .details(vinNumber)).execute { result in
            switch result {
                
            case .success(let details):
                completion(.success(details))
            case .failure(let error):
                let nsError = error as NSError
                completion(.failure(.genericError("\(nsError.description)- \(nsError.code)")))
            }
        }
    }
    
    func getCarLockStatus(vinNumber: String, completion: @escaping ((Result<CarLockStatusResponse, NetworkRequestError>) -> Void)) {
        NetworkRequest<CarLockStatusResponse>.init(request: .carLockStatus(vinNumber)).execute { result in
            switch result {
            case .success(let lockResponse):
                completion(.success(lockResponse))
            case .failure(let error):
                let nsError = error as NSError
                completion(.failure(.genericError("\(nsError.description)- \(nsError.code)")))
            }
        }
    }
    
    func getDoorStatus(vinNumber: String, completion: @escaping ((Result<DoorsAndWindowsLockStatusResponse, NetworkRequestError>) -> Void)) {
        NetworkRequest<DoorsAndWindowsLockStatusResponse>.init(request: .doorAndWindowsLockStatus(vinNumber)).execute { result in
            switch result {
            case .success(let lockResponse):
                completion(.success(lockResponse))
            case .failure(let error):
                let nsError = error as NSError
                completion(.failure(.genericError("\(nsError.description)- \(nsError.code)")))
            }
        }
    }
    
    func getImage(url: String, completion: @escaping ((Result<Data, NetworkRequestError>) -> Void)) {
        
        NetworkRequest<Generic>.init(request: .downloadImage(url)).downloadImage { result in
            switch result {
            case .success(let imageData):
                completion(.success(imageData))
                
            case .failure(let error):
                completion(.failure(.apiError(error.localizedDescription)))
            }
        }

    }
    
}

// MARK: - Private Methods
extension NetworkManager {
    
    private func performNetworkRequest(with url: URL, completion: @escaping ((Result<Data, NetworkRequestError>) -> Void)) {
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { data, response, error in
            
            guard let responseData = data else {
                if let error = error {
                    completion(.failure(.apiError(error.localizedDescription)))
                } else {
                    completion(.failure(.genericError("API call failed: Unknown error")))
                }
                
                return
            }
            
            completion(.success(responseData))
        }
        
        task.resume()
    }
}
