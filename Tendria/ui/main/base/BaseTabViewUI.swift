//
//  BaseTabViewUI.swift
//  Tendria
//
//  Created by Yakup Kavak on 2.02.2025.
//

import SwiftUI

struct BaseTabViewUI: View {
    
    @StateObject var routerTask = RouterTask()
    @StateObject var routerUser = RouterUser()
    
    var body: some View {
        
        TabView {
            FeedUI()
                .tabItem {
                    Label("Feed", systemImage: "house.fill")
                }
            HistoryUI()
                .tabItem {
                    Label("History", systemImage: "clock.fill")
                }
            
            TaskListContainerUI()
                .tabItem {
                    Label("Task", systemImage: "checkmark.circle.fill")
                }.environmentObject(routerTask)
            
            TreeUI()
                .tabItem {
                    Label("Tree", systemImage: "leaf.fill")
                }
            
            UserListContainerUI()
                .tabItem {
                    Label("User", systemImage: "person.fill")
                }.environmentObject(routerUser)
        }
        .accentColor(.blue) // Aktif sekme rengi
    }
}

#Preview {
    BaseTabViewUI()
}
