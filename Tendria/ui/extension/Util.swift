//
//  Util.swift
//  Tendria
//
//  Created by Yakup Kavak on 1.02.2025.
//

import Foundation
import SwiftUICore
import UIKit

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

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)

        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8) & 0xFF) / 255
        let b = Double(int & 0xFF) / 255

        self.init(red: r, green: g, blue: b)
    }

    func toHex() -> String? {
        let uiColor = UIColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: nil)
        return String(format: "#%02X%02X%02X", Int(red * 255), Int(green * 255), Int(blue * 255))
    }
}
