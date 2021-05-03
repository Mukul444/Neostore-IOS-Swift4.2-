//
//  OrderDetailDatum.swift
//  Neostore
//
//  Created by webwerks1 on 22/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import Foundation

struct OrderDetailDatum : Codable {
    
    let address : String?
    let cost : Int?
    let id : Int?
    let orderDetails : [OrderDetail]?
    
    enum CodingKeys: String, CodingKey {
        case address = "address"
        case cost = "cost"
        case id = "id"
        case orderDetails = "order_details"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        cost = try values.decodeIfPresent(Int.self, forKey: .cost)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        orderDetails = try values.decodeIfPresent([OrderDetail].self, forKey: .orderDetails)
    }
    
}
