//
//  AddGroupUI.swift
//  Tendria
//
//  Created by Yakup Kavak on 5.02.2025.
//

import SwiftUI
import _PhotosUI_SwiftUI

struct AddGroupUI: View {
    
    @EnvironmentObject var routerTask: RouterTask
    @StateObject var viewModel = AddGroupViewModel()
    let maxPhotoSelect = 1

    var body: some View {
        PhotosPicker(
            selection: $viewModel.selectedPhotos,
            maxSelectionCount: maxPhotoSelect,
            selectionBehavior: .ordered,
            matching: .images
        ) {
            Label("Select up to ^[\(maxPhotoSelect) photo](inflect: true)", systemImage: "photo")
        }.padding()
            .onChange(of: viewModel.selectedPhotos) { _ in
                viewModel.convertDataToImage()
            }
    }
}

#Preview {
    AddGroupUI()
}
