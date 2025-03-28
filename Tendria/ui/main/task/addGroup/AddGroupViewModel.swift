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
    @Published var selectedPhoto: PhotosPickerItem?
    @Published var userPhoto: UIImage? = nil
    @Published var textInput = ""
    @Published var success = false
    @Published var loading = false
    @Published var error = ""
    @Published var isImageSelected: Bool = false

    @MainActor
    func convertDataToImage() {
        images.removeAll()
        
        guard (selectedPhoto != nil) else { return }
        
        
        Task{
            if let imageData = try? await selectedPhoto!.loadTransferable(type: Data.self) {
                if let image = UIImage(data: imageData){
                    isImageSelected = true
                    userPhoto = image
                }
            }
        }
        
    }
    
    func saveListImage() {
        guard let imageData = userPhoto?.jpegData(compressionQuality: 0.8) else { return }
        
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
