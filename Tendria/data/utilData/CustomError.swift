//
//  CustomError.swift
//  Tendria
//
//  Created by Yakup Kavak on 19.02.2025.
//

import Foundation

enum RelationError: LocalizedError {
    case duplicateCode // Aynı kod oluştu hatası
    case unknown // Bilinmeyen hata
    
    var errorDescription: String? {
        switch self {
        case .duplicateCode:
            return NSLocalizedString("duplicate_code_error", comment: "Duplicate relation code found. Please generate a new one.")
        case .unknown:
            return NSLocalizedString("unknown_error", comment: "An unknown error occurred. Please try again.")
        }
    }
}
