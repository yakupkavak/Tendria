//
//  TaskNavigationManager.swift
//  Tendria
//
//  Created by Yakup Kavak on 5.02.2025.
//

import Foundation
import SwiftUI

final class RouterUser: ObservableObject {
    
    public enum Destination: Codable, Hashable {
        case existRelation
        case makeRelation
        case resetPassword
        case userInfo
        case userList
    }
    
    @Published var navPath = NavigationPath()
    
    func navigate(to destination: Destination) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
