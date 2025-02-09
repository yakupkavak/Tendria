//
//  AddGroupViewModel.swift
//  Tendria
//
//  Created by Yakup Kavak on 5.02.2025.
//

import Foundation
import _PhotosUI_SwiftUI

class AddGroupViewModel: BaseViewModel {
    @Published var images = [UIImage]()
    @Published var selectedPhotos = [PhotosPickerItem]()
    @Published var selectedPhoto: UIImage? = nil
    
    @MainActor
    func convertDataToImage() {
        images.removeAll()
        
        guard !selectedPhotos.isEmpty else { return }
        
        for eachItem in selectedPhotos {
            Task{
                //imagenin referansından veriyi çekiyoruz.
                if let imageData = try? await eachItem.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: imageData){
                        selectedPhoto = image
                    }
                }
            }
        }
    }
}
