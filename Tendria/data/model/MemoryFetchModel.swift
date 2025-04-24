//
//  Untitled.swift
//  Tendria
//
//  Created by Yakup Kavak on 2.04.2025.
//

import FirebaseCore
import FirebaseFirestore

struct MemoryFetchModel: Identifiable, Codable{
    @DocumentID var id: String?
    var imageUrl: String
    var title: String
    let userOneDescription: String?
    let userTwoDescription: String?
    let userOneImage: String?
    let userTwoImage: String?
    let createDate: Timestamp?
    
    enum CodingKeys: String, CodingKey {
      case id
      case imageUrl
      case title
      case userOneDescription
      case userTwoDescription
      case userOneImage
      case userTwoImage
      case createDate
    }
}
enum FetchDataList<T> {
    case exist([T])
    case nonExist
    
    private var caseName: String {
        switch self {
        case .exist: return "exist"
        case .nonExist: return "nonExist"
        }
    }
    
    func hasSameCase(as type: Self) -> Bool {
        return self.caseName == type.caseName
    }
}
