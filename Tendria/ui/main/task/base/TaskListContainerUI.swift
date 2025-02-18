//
//  TaskListContainerUI.swift/Users/yakupkavak/Desktop/SwiftProjects/Tendria/Tendria/ui/main/base/BaseTabViewUI.swift
//  Tendria
//
//  Created by Yakup Kavak on 5.02.2025.
//

import SwiftUI

struct TaskListContainerUI: View {
    
    @EnvironmentObject var routerBase: RouterBase
    
    var body: some View {
        TaskGroupListUI()
    }
}
