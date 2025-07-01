//
//  UserModel.swift
//  Tendria
//
//  Created by Yakup Kavak on 12.02.2025.
//

import Foundation

public struct UserModel: Codable {
    
    var profileImageUrl: String
    var relationId: String
    var userId: String?
    var fcmToken: String
    var name: String
    var surname: String
    var userLanguage: String
    
    enum CodingKeys: String, CodingKey {
        case profileImageUrl
        case relationId
        case userId
        case fcmToken
        case name
        case surname
        case userLanguage
    }
}

