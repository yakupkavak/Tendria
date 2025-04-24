//
//  Untitled.swift
//  Tendria
//
//  Created by Yakup Kavak on 2.04.2025.
//

import FirebaseCore

struct MemoryDocumentModel: Codable{
    let imageUrls: [String]
    let relationId: String
    let title: String
    let userOneDescription: String?
    let userTwoDescription: String?
    let userOneImage: String?
    let userTwoImage: String?
    let createDate: Timestamp

  enum CodingKeys: String, CodingKey {
    case imageUrls
    case title
    case relationId
    case userOneDescription
    case userTwoDescription
    case userOneImage
    case userTwoImage
    case createDate
  }
}
