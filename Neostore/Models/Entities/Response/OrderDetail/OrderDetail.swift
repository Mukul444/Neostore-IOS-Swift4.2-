//
//  OrderDetail.swift
//  Neostore
//
//  Created by webwerks1 on 22/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import Foundation

struct OrderDetail : Codable {
    
    let id : Int?
    let orderId : Int?
    let prodCatName : String?
    let prodImage : String?
    let prodName : String?
    let productId : Int?
    let quantity : Int?
    let total : Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case orderId = "order_id"
        case prodCatName = "prod_cat_name"
        case prodImage = "prod_image"
        case prodName = "prod_name"
        case productId = "product_id"
        case quantity = "quantity"
        case total = "total"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        orderId = try values.decodeIfPresent(Int.self, forKey: .orderId)
        prodCatName = try values.decodeIfPresent(String.self, forKey: .prodCatName)
        prodImage = try values.decodeIfPresent(String.self, forKey: .prodImage)
        prodName = try values.decodeIfPresent(String.self, forKey: .prodName)
        productId = try values.decodeIfPresent(Int.self, forKey: .productId)
        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
    }
    
}
