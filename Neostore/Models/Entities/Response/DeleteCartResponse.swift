//
//  DeleteCartResponse.swift
//  Neostore
//
//  Created by webwerks1 on 20/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import Foundation

struct DeleteCartResponse : Codable {
    
    let data : Bool?
    let message : String?
    let status : Int?
    let totalCarts : Int?
    let userMsg : String?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case status = "status"
        case totalCarts = "total_carts"
        case userMsg = "user_msg"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(Bool.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        totalCarts = try values.decodeIfPresent(Int.self, forKey: .totalCarts)
        userMsg = try values.decodeIfPresent(String.self, forKey: .userMsg)
    }
    
}
