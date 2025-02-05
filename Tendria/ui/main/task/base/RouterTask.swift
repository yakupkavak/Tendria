//
//  TaskNavigationManager.swift
//  Tendria
//
//  Created by Yakup Kavak on 5.02.2025.
//

import Foundation
import SwiftUI

final class RouterTask: ObservableObject {
    
    public enum Destination: Codable, Hashable {
        case taskGroupList
        case addGroupTask
        case taskDetailList
        case taskDetail
        case addTaskDetail
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
