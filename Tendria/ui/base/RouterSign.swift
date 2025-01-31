//
//  RouterSign.swift
//  Tendria
//
//  Created by Yakup Kavak on 20.01.2025.
//

import Foundation
import SwiftUI

final class RouterSign: ObservableObject {
    
    public enum Destination: Codable, Hashable {
        case signIn
        case signUp
        case forgotPassword
        case feed
    }
    
    @Published var navPath = NavigationPath()
    
    func navigate(to destination: Destination) {
        navPath = NavigationPath()
        navPath.append(destination)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
