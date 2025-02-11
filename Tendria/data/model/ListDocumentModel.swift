//
//  ListDocumentModel.swift
//  Tendria
//
//  Created by Yakup Kavak on 11.02.2025.
//

import Foundation

public struct ListDocumentModel: Codable {

    let imageUrl: String
    let relationId: String
    let taskIdList: [String]?
    let description: String

  enum CodingKeys: String, CodingKey {
    case imageUrl
    case relationId
    case taskIdList
    case description
  }
}
