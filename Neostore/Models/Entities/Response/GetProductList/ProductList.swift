//
//  RootClass.swift

//  Created on April 14, 2021

import Foundation

struct ProductList : Codable {
    
    let data : [ProductDetails]?
    let status : Int?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([ProductDetails].self, forKey: .data)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }
    
}
