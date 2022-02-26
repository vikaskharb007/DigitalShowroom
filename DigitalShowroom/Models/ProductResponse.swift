//
//  ProductResponse.swift
//  DigitalShowroom
//
//  Created by Vikas Kharb on 30/01/2022.
//

import Foundation

struct AllProductsResponse: Codable {
    var vins: [String]
}

struct VinDetailsResponse: Codable {
    var plate: String
    var imagePath: String
}

struct CarLockStatusResponse: Codable {
    var locked: Bool
}

struct DoorsAndWindowsLockStatusResponse: Codable {
    var doorRightBack: String
    var doorLeftFront: String
    var doorRightFront: String
    var doorLeftBack: String
}

struct Generic: Codable {}
