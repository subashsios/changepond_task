//
//  Untitled.swift
//  changebondTask
//
//  Created by Apple  on 10/02/26.
//

import Foundation

nonisolated struct ProductResponse: Codable, Sendable {
    let products: [Product]
}

struct Product: Codable, @unchecked Sendable {
    let id: Int?
    let title: String?
    let description: String?
    let category: String?
    let price: Double?
    let discountPercentage: Double?
    let rating: Double?
    let stock: Int?
    let brand: String?
    let sku: String?
    let weight: Int?
    let thumbnail: String?
    let warrantyInformation: String?
    let shippingInformation: String?
    let availabilityStatus: String?
}
