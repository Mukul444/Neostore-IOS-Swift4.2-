//
//  ListCartProduct.swift
//  Neostore
//
//  Created by webwerks1 on 19/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//


import Foundation

struct ListCartProduct : Codable {
    
    let cost : Int?
    let id : Int?
    let name : String?
    let productCategory : String?
    let productImages : String?
    let subTotal : Int?
    
    enum CodingKeys: String, CodingKey {
        case cost = "cost"
        case id = "id"
        case name = "name"
        case productCategory = "product_category"
        case productImages = "product_images"
        case subTotal = "sub_total"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cost = try values.decodeIfPresent(Int.self, forKey: .cost)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        productCategory = try values.decodeIfPresent(String.self, forKey: .productCategory)
        productImages = try values.decodeIfPresent(String.self, forKey: .productImages)
        subTotal = try values.decodeIfPresent(Int.self, forKey: .subTotal)
    }
    
}

