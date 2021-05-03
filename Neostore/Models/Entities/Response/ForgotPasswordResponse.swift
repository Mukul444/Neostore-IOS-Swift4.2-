//
//  ForgotPasswordResponse.swift
//  Neostore
//
//  Created by webwerks1 on 07/04/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct ForgotPasswordResponse: Codable {
    let status: Int
    let message, userMsg: String
    
    enum CodingKeys: String, CodingKey {
        case status, message
        case userMsg = "user_msg"
    }
}
