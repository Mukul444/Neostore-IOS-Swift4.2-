//
//  ListCartDatum.swift
//  Neostore
//
//  Created by webwerks1 on 19/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import Foundation

struct ListCartDatum : Codable {
    
    let id : Int?
    let product : ListCartProduct?
    let productId : Int?
    let quantity : Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case product = "product"
        case productId = "product_id"
        case quantity = "quantity"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        product = try values.decodeIfPresent(ListCartProduct.self, forKey: .product)
        productId = try values.decodeIfPresent(Int.self, forKey: .productId)
        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
    }
    
}
