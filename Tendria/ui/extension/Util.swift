//
//  Util.swift
//  Tendria
//
//  Created by Yakup Kavak on 1.02.2025.
//

import Foundation
import SwiftUICore

func getLocalizedString(_ key: LocalizedStringKey) -> String {
    let mirror = Mirror(reflecting: key)
    if let value = mirror.children.first?.value as? String {
        return NSLocalizedString(value, comment: "")
    }
    return ""
}

enum AlertType {
    case success, error
}
