//
//  BaseTabViewUI.swift
//  Tendria
//
//  Created by Yakup Kavak on 2.02.2025.
//

import SwiftUI

struct BaseTabViewUI: View {
    
    @EnvironmentObject private var routerTask: RouterTask
    @EnvironmentObject private var routerUser: RouterUserInfo
    @StateObject private var viewModel = BaseTabViewModel()
    
    var initialize = NotificationManager.shared
    
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
            NavigationStack(path: $routerTask.navPath) {
                TaskGroupListUI().environmentObject(routerTask).navigationDestination(for: RouterTask.Destination.self) { destination in
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
                    }
                }
            }.tabItem {
                    Label("Task", systemImage: "checkmark.circle.fill")
                }
            
            TreeUI()
                .tabItem {
                    Label("Tree", systemImage: "leaf.fill")
                }
            NavigationStack(path: $routerUser.navPath) {
                UserListUI().environmentObject(routerUser).navigationDestination(for: RouterUserInfo.Destination.self) { destination in
                    switch destination {
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
            }.tabItem {
                    Label("User", systemImage: "person.fill")
                }
        }.onAppear {
            print("BaseTabViewUI appeared. ViewModel: \(viewModel)")
        }
        .navigationBarBackButtonHidden()
        .accentColor(.blue) // Aktif sekme rengi
        .showNewRelation(isPresent: $viewModel.showRelationAlert, onSuccess: {
            viewModel.onSuccessClick()
        }, messageText: viewModel.alertMessage)
    }
}
/*
#Preview {
    BaseTabViewUI()
}

*/
