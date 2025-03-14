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
            Spacer()

            HStack{
                btnSystemIconTransparent(iconSystemName: "chevron.left", color: Color.black) {
                    isAddGroupPresented = false
                }
                tvHeadline(text: StringKey.add_collection, color: Color.blue500)
                Spacer()
            }.padding(.top,Padding.horizontalSmallPadding)
            Spacer()
            Spacer()
            PhotosPicker(
                selection: $viewModel.selectedPhotos,
                maxSelectionCount: maxPhotoSelect,
                selectionBehavior: .ordered,
                matching: .images
            ) {
                RowUIImage(uiImage: displayedPhoto ?? UIImage(named: IconName.imageUploadIcon) ?? UIImage())
            }
            Spacer()
            HStack{
                tvSubTitle(text: StringKey.title)
                Spacer()
            }.padding(6)
            tfText(placeHolder: StringKey.collection_name, textInput: $viewModel.textInput).padding(.bottom)
            HStack{
                tvSubTitle(text: StringKey.note)
                Spacer()
            }.padding(6)
            teText(placeHolder: StringKey.collection_comment, textInput: $emp).frame(height: Height.xLargeHeight).padding(.bottom)
            Spacer()
            btnTextGradient(action: {
                viewModel.saveListImage()
            }, text: StringKey.add).frame(width: Width.buttonHalfWidth)

            Spacer()
        }.padding()
        .onChange(of: viewModel.selectedPhotos) { _ in
            viewModel.convertDataToImage()
        }
        .onReceive(viewModel.$selectedPhoto) { selectedPhoto in
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
