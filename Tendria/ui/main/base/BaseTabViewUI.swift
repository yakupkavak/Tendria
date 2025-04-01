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
    @State var selectedTab: Tab = .feed
    
    var initialize = NotificationManager.shared
    @State private var isAddGroupPresented = false
    
    var body: some View {
        
        TabView(selection: $selectedTab, content: {
            FeedUI()
                .tabItem {
                    Label("Feed", systemImage: "house.fill")
                }.tag(Tab.feed)
            
            HistoryUI()
                .tabItem {
                    Label("History", systemImage: "clock.fill")
                }.tag(Tab.history)
            NavigationStack(path: $routerTask.navPath) {
                TaskGroupListUI(isAddGroupPresented: $isAddGroupPresented, selectedTab: $selectedTab).environmentObject(routerTask).environmentObject(routerUser).navigationDestination(for: RouterTask.Destination.self) { destination in
                    switch destination {
                    case .taskGroupList:
                        TaskGroupListUI(isAddGroupPresented: $isAddGroupPresented, selectedTab: $selectedTab).onAppear(){
                            isAddGroupPresented = false
                        }
                    case .addGroupTask:
                        TaskGroupListUI(isAddGroupPresented: $isAddGroupPresented, selectedTab: $selectedTab).onAppear {
                            isAddGroupPresented = true
                        }
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
            }.tag(Tab.task)
            
            TreeUI()
                .tabItem {
                    Label("Tree", systemImage: "leaf.fill")
                }.tag(Tab.tree)
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
            }.tag(Tab.user)
        }) .onAppear {
            print("BaseTabViewUI appeared. ViewModel: \(viewModel)")
        }
        .navigationBarBackButtonHidden()
        .accentColor(.blue) // Aktif sekme rengi
        .showNewRelation(isPresent: $viewModel.showRelationAlert, onSuccess: {
            viewModel.onSuccessClick()
        }, messageText: viewModel.alertMessage)
        .fullScreenCover(isPresented: $isAddGroupPresented) {
            AddGroupUI(isAddGroupPresented: $isAddGroupPresented)
        }
    }
}
enum Tab {
    case feed,history,task,tree,user
}
/*
 #Preview {
 BaseTabViewUI()
 }
 
 */
