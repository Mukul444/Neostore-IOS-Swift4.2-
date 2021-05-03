//
//  OrderDatum.swift
//  Neostore
//
//  Created by webwerks1 on 21/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import Foundation

struct OrderListDatum : Codable {
    
    let cost : Int?
    let created : String?
    let id : Int?
    
    enum CodingKeys: String, CodingKey {
        case cost = "cost"
        case created = "created"
        case id = "id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cost = try values.decodeIfPresent(Int.self, forKey: .cost)
        created = try values.decodeIfPresent(String.self, forKey: .created)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
    }
    
}
