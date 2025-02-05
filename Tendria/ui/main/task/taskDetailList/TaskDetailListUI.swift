//
//  TaskDetailListUI.swift
//  Tendria
//
//  Created by Yakup Kavak on 5.02.2025.
//

import SwiftUI

struct TaskDetailListUI: View {
    
    @EnvironmentObject var routerTask: RouterTask

    var body: some View {
        ZStack { // List ve butonu üst üste koyuyoruz
            List {
                ForEach(taskRowList) { task in
                    Button {
                        routerTask.navigate(to: .taskDetail)
                    } label: {
                        TaskRowUI(url: task.imageUrl, subText: task.subText)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.white)
            }
            .listStyle(.plain)

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    btnAddIcon(iconName: "plus") {
                        routerTask.navigate(to: .addTaskDetail)
                    }.padding()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        }
    }
}

#Preview {
    TaskDetailListUI()
}
