//
//  TaskListContainerUI.swift/Users/yakupkavak/Desktop/SwiftProjects/Tendria/Tendria/ui/main/base/BaseTabViewUI.swift
//  Tendria
//
//  Created by Yakup Kavak on 5.02.2025.
//

import SwiftUI

struct TaskListContainerUI: View {
    
    @EnvironmentObject var routerTask: RouterTask

    var body: some View {
        NavigationStack(path: $routerTask.navPath) {
            TaskGroupListUI()
                .navigationDestination(for: RouterTask.Destination.self) { destination in
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
                }.environmentObject(routerTask)
        }
    }
}
