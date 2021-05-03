//
//   GetUserData.swift    Datum.swift    UserDatum.swift    ProductCategory.swift
//  Neostore
//
//  Created by webwerks1 on 12/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import Foundation

struct ProductCategory : Codable {
    
    let created : String?
    let iconImage : String?
    let id : Int?
    let modified : String?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        case created = "created"
        case iconImage = "icon_image"
        case id = "id"
        case modified = "modified"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        created = try values.decodeIfPresent(String.self, forKey: .created)
        iconImage = try values.decodeIfPresent(String.self, forKey: .iconImage)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        modified = try values.decodeIfPresent(String.self, forKey: .modified)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
    
}
