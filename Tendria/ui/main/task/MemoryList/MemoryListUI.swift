//
//  TaskDetailListUI.swift
//  Tendria
//
//  Created by Yakup Kavak on 5.02.2025.
//

import SwiftUI
import FirebaseCore

struct MemoryListUI: View {
    
    @EnvironmentObject var routerTask: RouterMemory
    @StateObject private var viewModel: MemoryListViewModel
    var collectionData: CollectionFetchModel
    @Binding var isAddMemoryPresented: Bool
    
    init(collectionData: CollectionFetchModel,isAddMemoryPresented: Binding<Bool>) {
        self.collectionData = collectionData
        self._isAddMemoryPresented = isAddMemoryPresented
        self._viewModel = StateObject(wrappedValue: MemoryListViewModel(collectionId: collectionData.id ?? ""))
    }
    
    var body: some View {
        ZStack {
            if viewModel.loading{
                CustomLottieView(animationFileName: LottieSet.LOADING_CIRCLE_JSON, isDotLottieFile: false, loopMode: .loop)
            }else if let success = viewModel.success{
                switch success {
                case .exist(let memoryArray):
                    VStack{
                        RowURLImage(imageUrl: collectionData.imageUrl,shouldCancelOnDisappear: true)
                        tvHeadlineString(text: collectionData.title, color: .blue500)
                        
                        List {
                            ForEach(memoryArray) { memory in
                                Button {
                                    routerTask.navigate(to: .addMemory)
                                } label: {
                                    CollectionRowUI(url: memory.imageUrl, subText: memory.title, shouldCancelOnDisappear: true)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.white)
                        }
                        .listStyle(.plain)
                    }
                    

                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            btnAddIcon(iconName: "plus") {
                                routerTask.navigate(to: .addMemory)
                            }.padding()
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                case .nonExist:
                    VStack{
                        CustomLottieView(animationFileName: LottieSet.NO_DATA_FOUND_JSON, isDotLottieFile: false, loopMode: .loop).frame(width: Width.screenSeventyWidth)
                        tvBodyline(text: StringKey.noneMemoryTitle, color: .blue500).padding(.bottom)
                        tvFootnote(text: StringKey.noneMemoryText, color: .brown300,textAlignment: .leading).padding(.horizontal,Padding.constantLargePadding)
                        Spacer()
                        HStack {
                            Spacer()
                            btnAddIcon(iconName: "plus") {
                                isAddMemoryPresented = true
                            }.padding()
                        }
                    }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                }
            }
        }
    }
}

#Preview {
    var data = CollectionFetchModel(imageUrl: "https://antalyabalikevi.com.tr/wp-content/uploads/2020/04/antalya-sarapevi.jpg", title: "DenemeTitle", relationId: "", userOneDescription: "", userTwoDescription: "", userOneImage: "", userTwoImage: "", createDate: Timestamp(date: Date()))
    @State var isPres = true
    MemoryListUI(collectionData: data, isAddMemoryPresented: $isPres)
     
}
