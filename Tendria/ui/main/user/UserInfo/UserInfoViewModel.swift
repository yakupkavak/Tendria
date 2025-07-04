//
//  UserInfoViewModel.swift
//  Tendria
//
//  Created by Yakup Kavak on 11.02.2025.
//

import Foundation
import FirebaseAuth
import UIKit
import FirebaseStorage
import FirebaseFirestore
import _PhotosUI_SwiftUI

@MainActor
final class UserInfoViewModel: BaseViewModel {
    @Published var user: UserModel = UserModel(profileImageUrl: "",
                                               relationId: "",
                                               userId: nil,
                                               fcmToken: "",
                                               name: "",
                                               surname: "",
                                               userLanguage: "en")
    @Published var nameInput = ""
    @Published var surnameInput = ""
    @Published var mobileInput = ""
    @Published var emailInput = ""
    @Published var success = false
    @Published var loading = false
    @Published var error = ""
    @Published var selectedPhoto: PhotosPickerItem?
    @Published var userBeforeCrop: UIImage? = nil
    @Published var userPhoto: UIImage? = nil //kullanıcının göreceği görsel
    @Published var isImageSelected: Bool = false
    
    @MainActor
    func convertDataToImage() {
        
        guard (selectedPhoto != nil) else { return }
        
        Task{
            if let imageData = try? await selectedPhoto!.loadTransferable(type: Data.self) {
                if let image = UIImage(data: imageData){
                    userBeforeCrop = image
                }
            }
        }
    }
    
    func putCroppedImage(croppedImage: UIImage){
        isImageSelected = true
        userPhoto = croppedImage
    }
    
    func saveCollectionImage() {
        guard let imageData = userPhoto?.jpegData(compressionQuality: 0.8) else { return }
        guard RelationRepository.shared.relationId != nil else {return} //TODO BU HATA ELE ALINACAK
        getDataCall {
            try await FirestorageManager.shared.addCollectionImage(imageData: imageData)
        } onSuccess: { downloadUrl in
            //self.saveCollectionDocument(downloadUrl: downloadUrl)
        } onLoading: {
            self.loading = true
        } onError: { error in
            self.error = error?.localizedDescription ?? ""
        }
    }
    /*
    func saveCollectionDocument(downloadUrl: String) {
        guard let relationId = RelationRepository.shared.relationId else {return}
        let listDocumentModel = CollectionDocumentModel(imageUrl: downloadUrl, title: titleInput, relationId: relationId, description: commentInput, createDate: Timestamp(date: Date()))
        getDataCall {
            try await FirestorageManager.shared.addCollectionDocument(collectionDocumentModel: listDocumentModel)
        } onSuccess: { success in
            self.loading = false
            self.success = true
        } onLoading: {
            self.loading = true
        } onError: { error in
            self.error = error?.localizedDescription ?? ""
        }
    }
     */
    func updateImage(){
        
    }
    
    func saveProfile(){
        
    }

}
