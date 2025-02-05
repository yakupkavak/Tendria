//
//  TaskListContainerUI.swift
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
                        TaskGroupListUI().environmentObject(routerTask)
                    case .addGroupTask:
                        AddGroupUI().environmentObject(routerTask)
                    case .taskDetailList:
                        TaskDetailListUI().environmentObject(routerTask)
                    case .taskDetail:
                        TaskDetailUI().environmentObject(routerTask)
                    case .addTaskDetail:
                        AddTaskUI().environmentObject(routerTask)
                    }
                }.environmentObject(routerTask)
        }
    }
}
