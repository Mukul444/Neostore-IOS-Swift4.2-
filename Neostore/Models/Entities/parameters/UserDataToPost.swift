//
//  UserDataToPost.swift
//  Neostore
//
//  Created by webwerks1 on 23/03/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import Foundation
struct UserPost : Codable {
    let firstName : String?
    let lastName : String?
    let email : String?
    let password : String?
    let confirmPassword : String?
    let gender : String?
    let phoneNo : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case firstName = "first_name"
        case lastName = "last_name"
        case email = "email"
        case password = "password"
        case confirmPassword = "confirm_password"
        case gender = "gender"
        case phoneNo = "phone_no"
    }
    
   
    
}
