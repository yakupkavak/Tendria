//
//  RelationCodeModel.swift
//  Tendria
//
//  Created by Yakup Kavak on 12.02.2025.
//

import Foundation

public struct RelationCodeModel: Codable {

    let firstUserId: String?
    let secondUserId: String?
    let relationCode: String

  enum CodingKeys: String, CodingKey {
    case firstUserId
    case secondUserId
    case relationCode
  }
}
