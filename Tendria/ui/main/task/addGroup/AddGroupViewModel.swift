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
    
    func saveListImage() {
        if let user = Auth.auth().currentUser {
            print("User is signed in: \(user.uid)")
        } else {
            print("No user is signed in!")
        }
        guard let imageData = selectedPhoto?.jpegData(compressionQuality: 0.8) else { return }
        
        Task {
            do {
                try await FirestorageManager.shared.addList(imageData: imageData)
            } catch {
                print("Image upload failed: \(error.localizedDescription)")
            }
        }
    }
}
