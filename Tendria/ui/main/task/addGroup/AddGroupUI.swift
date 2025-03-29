//
//  AddGroupUI.swift
//  Tendria
//
//  Created by Yakup Kavak on 5.02.2025.
//

import SwiftUI
import PhotosUI

struct AddGroupUI: View {
    
    @Binding var isAddGroupPresented: Bool
    @StateObject var viewModel = AddGroupViewModel()
    @State private var displayedPhoto: UIImage? = nil
    @State var emp = ""
    
    let maxPhotoSelect = 1
    
    var body: some View {
        VStack{
            HStack{
                btnSystemIconTransparent(iconSystemName: "chevron.left", color: Color.black) {
                    isAddGroupPresented = false
                }
                tvHeadline(text: StringKey.add_collection, color: Color.blue500)
                Spacer()
            }.padding(.leading,Padding.leadingMediumPadding)
            
            PhotosPicker(
                selection: $viewModel.selectedPhoto,
                matching: .images
            ) {
                UploadImageUI(uiImage: displayedPhoto ?? UIImage(named: IconName.imageUploadIcon) ?? UIImage(), height: Height.xxLargePlusHeight, width: Width.screenEightyWidth, unSelectedHeight: Height.xxLargeHeight, isImageSelected: $viewModel.isImageSelected)
                
            }.padding(.top, viewModel.isImageSelected ? 0 : Padding.horizontalNormalPlusPadding).padding(.bottom,viewModel.isImageSelected ? 0 : Padding.horizontalNormalPadding)
            HStack{
                tvSubTitle(text: StringKey.title)
                Spacer()
            }.padding()
            tfText(placeHolder: StringKey.collection_name, textInput: $viewModel.textInput).padding(.horizontal)
            
            HStack{
                tvSubTitle(text: StringKey.note)
                Spacer()
            }.padding()
            teText(placeHolder: StringKey.collection_comment, textInput: $emp).frame(height: Height.xLargeHeight).padding(.horizontal)
            
            btnTextGradient(shadow: Radius.shadowSmallRadius, action: {
                viewModel.saveListImage()
            }, text: StringKey.add).frame(width: Width.screenHalfWidth).padding(.top,Padding.horizontalNormalPlusPadding)
        }
            .onChange(of: viewModel.selectedPhoto) { _ in
                viewModel.convertDataToImage()
            }
            .onReceive(viewModel.$userPhoto) { selectedPhoto in
                Task { @MainActor in
                    displayedPhoto = selectedPhoto
                }
            }.ignoresSafeArea()
        
    }
}

#Preview {
    @State var isAddGroupPresented = true
    AddGroupUI(isAddGroupPresented: $isAddGroupPresented)
}
