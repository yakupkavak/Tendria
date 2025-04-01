//
//  TaskRowModel.swift
//  Tendria
//
//  Created by Yakup Kavak on 4.02.2025.
//

import Foundation
import FirebaseFirestore

struct CollectionRowModel: Identifiable,Codable{
    @DocumentID var id: String?
    var imageUrl: String
    var title: String
    var relationId: String
    
    enum CodingKeys: String, CodingKey {
      case id
      case imageUrl
      case title
      case relationId
    }
}
enum IsCollectionExist {
    case exist([CollectionRowModel])
    case nonExist
    case noneRelation
    
    private var caseName: String {
        switch self {
        case .exist: return "exist"
        case .nonExist: return "nonExist"
        case .noneRelation: return "noneRelation"
        }
    }
    
    func hasSameCase(as type: Self) -> Bool {
        return self.caseName == type.caseName
    }
}
