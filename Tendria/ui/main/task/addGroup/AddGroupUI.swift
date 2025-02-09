//
//  AddGroupUI.swift
//  Tendria
//
//  Created by Yakup Kavak on 5.02.2025.
//

import SwiftUI
import PhotosUI

struct AddGroupUI: View {
    
    @EnvironmentObject var routerTask: RouterTask
    @StateObject var viewModel = AddGroupViewModel()
    @State private var displayedPhoto: UIImage? = nil
    
    let maxPhotoSelect = 1
    
    var body: some View {
        PhotosPicker(
            selection: $viewModel.selectedPhotos,
            maxSelectionCount: maxPhotoSelect,
            selectionBehavior: .ordered,
            matching: .images
        ) {
            RowUIImage(uiImage: displayedPhoto ?? UIImage(named: IconName.imageUploadIcon) ?? UIImage())
        }.padding()
            .onChange(of: viewModel.selectedPhotos) { _ in
                viewModel.convertDataToImage()
            }
            .onReceive(viewModel.$selectedPhoto) { selectedPhoto in
                Task { @MainActor in
                    displayedPhoto = selectedPhoto
                }
            }
    }
}

#Preview {
    AddGroupUI()
}
