//
//  ProductDetailsCellViewModel.swift
//  DigitalShowroom
//
//  Created by Vikas Kharb on 30/01/2022.
//

import UIKit

class ProductListCellViewModel: ObservableObject {
    var productDetails: ProductListModel
    
    @Published var downloadedImage: UIImage?
    @Published var imageDownloadError: NetworkRequestError?
    
    init(productData: ProductListModel) {
        self.productDetails = productData
    }
    
    func downloadImage(imageURL: String) {
        NetworkManager.shared.getImage(url: imageURL) { [weak self] result in
            switch result {
            case .success( let imageData):
                guard let image = UIImage(data: imageData) else {
                    return
                }
                
                self?.downloadedImage = image
                
            case .failure:
                self?.imageDownloadError = .apiError("Failed to download Image")
            }
        }
    }
}
