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
    let title: String
    let description: String

  enum CodingKeys: String, CodingKey {
    case imageUrl
    case title
    case relationId
    case description
  }
}
