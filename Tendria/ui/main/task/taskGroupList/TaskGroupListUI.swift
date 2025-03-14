//
//  TaskUI.swift
//  Tendria
//
//  Created by Yakup Kavak on 2.02.2025.
//

import SwiftUI

struct TaskGroupListUI: View {
    
    @EnvironmentObject var routerTask: RouterTask
    @Binding var isAddGroupPresented: Bool
    
    var body: some View {
        ZStack { // List ve butonu üst üste koyuyoruz
            List {
                ForEach(taskRowList) { task in
                    Button {
                        routerTask.navigate(to: .taskDetailList)
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
                        isAddGroupPresented = true
                    }.padding()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        }
    }
}


#Preview {
    @State var isAddGroupPresented = false
    TaskGroupListUI(isAddGroupPresented: $isAddGroupPresented)
}
