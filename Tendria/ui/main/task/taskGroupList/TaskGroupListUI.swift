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
        ZStack {
            if viewModel.loading{
                CustomLottieView(animationFileName: LottieSet.LOADING_CIRCLE_JSON, isDotLottieFile: false, loopMode: .loop)
            }else if let success = viewModel.success{
                switch success {
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
                    VStack{
                        CustomLottieView(animationFileName: LottieSet.NO_DATA_FOUND_JSON, isDotLottieFile: false, loopMode: .loop).frame(width: Width.screenSeventyWidth)
                        tvSubHeadline(text: StringKey.noneCollectionTitle, color: .blue500).padding(.bottom)
                        tvFootnote(text: StringKey.noneCollectionText, color: .brown300,textAlignment: .leading).padding(.horizontal,32)
                        Spacer()
                        HStack {
                            Spacer()
                            btnAddIcon(iconName: "plus") {
                                isAddGroupPresented = true
                            }.padding()
                        }
                    }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                case .noneRelation:
                    Text("yakup")
                }
            }
        }
    }
}


#Preview {
    @State var isAddGroupPresented = false
    TaskGroupListUI(isAddGroupPresented: $isAddGroupPresented)
}
