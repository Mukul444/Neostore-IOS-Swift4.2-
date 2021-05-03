//
//  ProductData.swift
//  Neostore
//
//  Created by webwerks1 on 16/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import Foundation
struct ProductData : Codable {
    
    let cost : Int?
    let created : String?
    let descriptionField : String?
    let id : Int?
    let modified : String?
    let name : String?
    let producer : String?
    let productCategoryId : Int?
    let productImages : [ProductImage]?
    let rating : Int?
    let viewCount : Int?
    
    enum CodingKeys: String, CodingKey {
        case cost = "cost"
        case created = "created"
        case descriptionField = "description"
        case id = "id"
        case modified = "modified"
        case name = "name"
        case producer = "producer"
        case productCategoryId = "product_category_id"
        case productImages = "product_images"
        case rating = "rating"
        case viewCount = "view_count"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cost = try values.decodeIfPresent(Int.self, forKey: .cost)
        created = try values.decodeIfPresent(String.self, forKey: .created)
        descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        modified = try values.decodeIfPresent(String.self, forKey: .modified)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        producer = try values.decodeIfPresent(String.self, forKey: .producer)
        productCategoryId = try values.decodeIfPresent(Int.self, forKey: .productCategoryId)
        productImages = try values.decodeIfPresent([ProductImage].self, forKey: .productImages)
        rating = try values.decodeIfPresent(Int.self, forKey: .rating)
        viewCount = try values.decodeIfPresent(Int.self, forKey: .viewCount)
    }
    
}
