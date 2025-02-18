//
//  TaskUI.swift
//  Tendria
//
//  Created by Yakup Kavak on 2.02.2025.
//

import SwiftUI

struct TaskGroupListUI: View {
    
    @EnvironmentObject var routerApp: RouterBase
    
    var body: some View {
        ZStack { // List ve butonu üst üste koyuyoruz
            List {
                ForEach(taskRowList) { task in
                    Button {
                        routerApp.navigate(to: .taskDetailList)
                    } label: {
                        TaskRowUI(url: task.imageUrl, subText: task.subText)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.white)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden) // yukarı çıkarken gözüken alanı kapatır

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    btnAddIcon(iconName: "plus") {
                        routerApp.navigate(to: .addGroupTask)
                    }.padding()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        }
    }
}


#Preview {
    TaskGroupListUI()
}
