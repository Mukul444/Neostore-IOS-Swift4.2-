//
//  OrderResponse.swift
//  Neostore
//
//  Created by webwerks1 on 21/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import Foundation

struct OrderResponse : Codable {
    
    let message : String?
    let status : Int?
    let userMsg : String?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case status = "status"
        case userMsg = "user_msg"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        userMsg = try values.decodeIfPresent(String.self, forKey: .userMsg)
    }
    
}
