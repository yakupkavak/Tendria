//
//  NotificationModel.swift
//  Tendria
//
//  Created by Yakup Kavak on 7.03.2025.
//

import Foundation

public enum NotificationRequestType {
    case navigateSettings
    case requestNotification
}

public enum HandleNotification {
    case newRelation
}

public struct NotificationData{
    var object: Any?
    var notificationType: HandleNotification
}

struct NotificationJSONData: Codable {
    let alertType: String
    let relationId: String
}
