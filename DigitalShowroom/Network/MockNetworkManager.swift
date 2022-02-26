//
//  MockNetworkManager.swift
//  DigitalShowroom
//
//  Created by Vikas Kharb on 30/01/2022.
//

import Foundation

class MockNetworkManager: NetworkServicesProtocol {
    
    static let shared = MockNetworkManager()
    
    private init() {}
    
    func getVinDetails(vinNumber: String, completion: @escaping ((Result<VinDetailsResponse, NetworkRequestError>) -> Void)) {
        readFileData(fileName: "VinDetails") { [weak self] isSuccess, fileData in
            guard let data = fileData,
                  isSuccess,
                  let decodedData = self?.decodeData(input: data, withType: VinDetailsResponse.self)
            else {
                completion(.failure(.jsonParseError))
                return
            }
            
            completion(.success(decodedData))
        }
    }
    
    func getAllProducts(completion: @escaping ((Result<AllProductsResponse, NetworkRequestError>) -> Void)) {
        readFileData(fileName: "Vins") { [weak self] isSuccess, fileData in
            guard let data = fileData,
                  isSuccess,
                  let decodedData = self?.decodeData(input: data, withType: AllProductsResponse.self)
            else {
                completion(.failure(.jsonParseError))
                return
            }
            
            completion(.success(decodedData))
        }
    }
    
    func getCarLockStatus(vinNumber: String, completion: @escaping ((Result<CarLockStatusResponse, NetworkRequestError>) -> Void)) {
        completion(.success(CarLockStatusResponse(locked: true)))
    }
    
    func getDoorStatus(vinNumber: String, completion: @escaping ((Result<DoorsAndWindowsLockStatusResponse, NetworkRequestError>) -> Void)) {
        completion(.success(DoorsAndWindowsLockStatusResponse(doorRightBack: "closed", doorLeftFront: "open", doorRightFront: "closed", doorLeftBack: "closed")))
    }
}

extension MockNetworkManager {
    
    private func decodeData<T: Decodable>(input: Data, withType: T.Type) -> T? {
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: input)
            return decodedData
        } catch let error as NSError {
            debugPrint(error.localizedDescription)
            return nil
        }
    }
    
    private func readFileData(fileName: String, completion: @escaping (_ isSuccess: Bool, _ parsedData: Data?) -> Void) {
        if let path = pathFor(file: fileName) {
            do {
                let filedata = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                completion(true , filedata)
            } catch let error {
                print(error.localizedDescription)
                completion(false , nil)
            }
        } else {
            completion(false , nil)
        }
    }
    
    private func pathFor(file: String) -> String? {
        return Bundle.main.path(forResource: file, ofType: "json")
    }
}
