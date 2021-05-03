//
//  ProductImage.swift
//  Neostore
//
//  Created by webwerks1 on 16/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import Foundation

struct ProductImage : Codable {
    
    let created : String?
    let id : Int?
    let image : String?
    let modified : String?
    let productId : Int?
    
    enum CodingKeys: String, CodingKey {
        case created = "created"
        case id = "id"
        case image = "image"
        case modified = "modified"
        case productId = "product_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        created = try values.decodeIfPresent(String.self, forKey: .created)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        modified = try values.decodeIfPresent(String.self, forKey: .modified)
        productId = try values.decodeIfPresent(Int.self, forKey: .productId)
    }
    
}
