//
//  RelationshipModel.swift
//  Tendria
//
//  Created by Yakup Kavak on 26.02.2025.
//

import Foundation
import FirebaseCore

public struct RelationshipModel: Codable {

    let firstUserId: String
    let secondUserId: String?
    let createDate: Timestamp

  enum CodingKeys: String, CodingKey {
    case firstUserId
    case secondUserId
    case createDate
  }
}
