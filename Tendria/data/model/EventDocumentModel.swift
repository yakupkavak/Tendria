//
//  EventModel.swift
//  Tendria
//
//  Created by Yakup Kavak on 11.05.2025.
//

import Foundation
import FirebaseFirestore
import FirebaseCore

struct EventDocumentModel: Identifiable,Codable,Equatable,Hashable{
    @DocumentID var id: String?
    let relationId: String
    var title: String
    var comment: String
    var eventDate: Timestamp
    var startHour: Timestamp
    var finishHour: Timestamp
    var category: CategoryModel
    var isRepeat: Bool
    var isRemind: Bool
    
    enum CodingKeys: String, CodingKey {
      case id
      case relationId
      case title
      case comment
      case eventDate
      case startHour
      case finishHour
      case category
      case isRepeat
      case isRemind
    }
}
