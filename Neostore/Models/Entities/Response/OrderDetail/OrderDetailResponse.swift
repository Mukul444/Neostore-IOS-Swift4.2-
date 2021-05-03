//
//  OrderDetailResponse.swift
//  Neostore
//
//  Created by webwerks1 on 22/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import Foundation

struct OrderDetailResponse : Codable {
    
    let data : OrderDetailDatum?
    let status : Int?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(OrderDetailDatum.self, forKey: .data)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }
    
}
