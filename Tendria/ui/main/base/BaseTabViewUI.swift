//
//  BaseTabViewUI.swift
//  Tendria
//
//  Created by Yakup Kavak on 2.02.2025.
//

import SwiftUI

struct BaseTabViewUI: View {
    
    @StateObject var routerTask = RouterTask()
    
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
            
            UserUI()
                .tabItem {
                    Label("User", systemImage: "person.fill")
                }
        }.background(.ultraThinMaterial)
        .accentColor(.blue) // Aktif sekme rengi
    }
}

#Preview {
    BaseTabViewUI()
}
