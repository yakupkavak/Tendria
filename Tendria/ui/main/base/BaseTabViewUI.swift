//
//  BaseTabViewUI.swift
//  Tendria
//
//  Created by Yakup Kavak on 2.02.2025.
//

import SwiftUI

struct BaseTabViewUI: View {
    
    @EnvironmentObject var routerApp: RouterBase
    
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
            
            TaskGroupListUI()
                .tabItem {
                    Label("Task", systemImage: "checkmark.circle.fill")
                }
            
            TreeUI()
                .tabItem {
                    Label("Tree", systemImage: "leaf.fill")
                }
            UserListUI()
                .tabItem {
                    Label("User", systemImage: "person.fill")
                }
        }
        .navigationBarBackButtonHidden()
        .accentColor(.blue) // Aktif sekme rengi
    }
}
/**
 .navigationDestination(for: RouterBase.Destination.self) { destination in
     switch destination {
     case .taskGroupList:
         TaskGroupListUI()
     case .addGroupTask:
         AddGroupUI()
     case .taskDetailList:
         TaskDetailListUI()
     case .taskDetail:
         TaskDetailUI()
     case .addTaskDetail:
         AddTaskUI()
     case .existRelation:
         ExistRelationUI()
     case .makeRelation:
         MakeRelationUI()
     case .resetPassword:
         ResetPasswordUI()
     case .userInfo:
         UserInfoUI()
     case .userList:
         UserListUI()
     }
 }
 */

#Preview {
    BaseTabViewUI()
}
