//
//  TaskNavigationManager.swift
//  Tendria
//
//  Created by Yakup Kavak on 5.02.2025.
//

import Foundation
import SwiftUI

final class RouterBase: ObservableObject {
    
    public enum Destination: Codable, Hashable {
        //Group List
        case taskGroupList
        case addGroupTask
        case taskDetailList
        case taskDetail
        case addTaskDetail
        //User List
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
