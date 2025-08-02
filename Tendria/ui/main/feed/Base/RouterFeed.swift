//
//  FeedRouter.swift
//  Tendria
//
//  Created by Yakup Kavak on 30.07.2025.
//

import Foundation
import SwiftUI

final class RouterFeed: ObservableObject {
    
    public enum Destination: Codable, Hashable {
        case feedView
        case question
        case story
        case whatIf
        case truthLie
    }
    
    @Published var navPath = NavigationPath()
    
    func navigate(to destination: Destination) {
        navPath.append(destination)
        print("feed",navPath)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
