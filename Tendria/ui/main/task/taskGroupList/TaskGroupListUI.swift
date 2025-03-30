//
//  TaskUI.swift
//  Tendria
//
//  Created by Yakup Kavak on 2.02.2025.
//

import SwiftUI

struct TaskGroupListUI: View {
    
    @EnvironmentObject var routerTask: RouterTask
    @StateObject private var viewModel = TaskGroupListViewModel()
    @Binding var isAddGroupPresented: Bool
    
    var body: some View {
        ZStack { // List ve butonu üst üste koyuyoruz
            if viewModel.loading{
                CustomLottieView(animationFileName: LottieSet.LOADING_CIRCLE_JSON, isDotLottieFile: false, loopMode: .loop)
            }
            switch viewModel.success {
            case .exist(let collectionRowList):
                List {
                    ForEach(collectionRowList) { collection in
                        Button {
                            routerTask.navigate(to: .taskDetailList)
                        } label: {
                            TaskRowUI(url: collection.imageUrl, subText: collection.title)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.white)
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)

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
            case .nonExist:
                List {
                    ForEach(taskRowList) { collection in
                        Button {
                            routerTask.navigate(to: .taskDetailList)
                        } label: {
                            TaskRowUI(url: collection.imageUrl, subText: collection.title)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.white)
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)

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
}


#Preview {
    @State var isAddGroupPresented = false
    TaskGroupListUI(isAddGroupPresented: $isAddGroupPresented)
}
