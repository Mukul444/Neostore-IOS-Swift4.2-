//
//  ListCartResponse.swift
//  Neostore
//
//  Created by webwerks1 on 19/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//
import Foundation

struct ListCartResponse : Codable {
    
    let count : Int?
    let data : [ListCartDatum]?
    let status : Int?
    let total : Int?
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case data = "data"
        case status = "status"
        case total = "total"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        data = try values.decodeIfPresent([ListCartDatum].self, forKey: .data)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
    }
    
}
