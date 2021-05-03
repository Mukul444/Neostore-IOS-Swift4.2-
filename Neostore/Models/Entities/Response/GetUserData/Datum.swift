//
//  Datum.swift
//  Neostore
//
//  Created by webwerks1 on 12/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import Foundation

struct Datum : Codable {
    
    let productCategories : [ProductCategory]?
    let totalCarts : Int?
    let totalOrders : Int?
    let userData : UserDatum?
    
    enum CodingKeys: String, CodingKey {
        case productCategories = "product_categories"
        case totalCarts = "total_carts"
        case totalOrders = "total_orders"
        case userData = "user_data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        productCategories = try values.decodeIfPresent([ProductCategory].self, forKey: .productCategories)
        totalCarts = try values.decodeIfPresent(Int.self, forKey: .totalCarts)
        totalOrders = try values.decodeIfPresent(Int.self, forKey: .totalOrders)
        userData = try values.decodeIfPresent(UserDatum.self, forKey: .userData)
    }
    
}

