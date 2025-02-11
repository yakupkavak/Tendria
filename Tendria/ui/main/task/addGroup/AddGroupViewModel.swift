//
//  AddGroupViewModel.swift
//  Tendria
//
//  Created by Yakup Kavak on 5.02.2025.
//

import Foundation
import _PhotosUI_SwiftUI
import FirebaseAuth

class AddGroupViewModel: BaseViewModel {
    @Published var images = [UIImage]()
    @Published var selectedPhotos = [PhotosPickerItem]()
    @Published var selectedPhoto: UIImage? = nil
    @Published var textInput = ""
    @Published var success = false
    @Published var loading = false
    @Published var error = ""

    @MainActor
    func convertDataToImage() {
        images.removeAll()
        
        guard !selectedPhotos.isEmpty else { return }
        
        for eachItem in selectedPhotos {
            Task{
                if let imageData = try? await eachItem.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: imageData){
                        selectedPhoto = image
                    }
                }
            }
        }
    }
    
    func saveListImage() {
        guard let imageData = selectedPhoto?.jpegData(compressionQuality: 0.8) else { return }
        
        getDataCall {
            try await FirestorageManager.shared.addListImage(imageData: imageData)
        } onSuccess: { downloadUrl in
            self.saveListDocument(downloadUrl: downloadUrl)
        } onLoading: {
            self.loading = true
        } onError: { error in
            self.error = error?.localizedDescription ?? ""
        }
    }
    
    func saveListDocument(downloadUrl: String) {
        getDataCall {
            try await FirestorageManager.shared.addListDocument(downloadUrl: downloadUrl,description: self.textInput)
        } onSuccess: { success in
            self.loading = false
            self.success = true
        } onLoading: {
            self.loading = true
        } onError: { error in
            self.error = error?.localizedDescription ?? ""
        }
    }

}
