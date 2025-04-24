//
//  UserModel.swift
//  Tendria
//
//  Created by Yakup Kavak on 12.02.2025.
//

import Foundation


public struct UserModel: Codable {
    
    let profileImageUrl: String
    let relationId: String
    let userId: String?
    
    enum CodingKeys: String, CodingKey {
        case profileImageUrl
        case relationId
        case userId
    }
}

