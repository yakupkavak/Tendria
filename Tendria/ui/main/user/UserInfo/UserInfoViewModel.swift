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
    @Published var user: UserModel = UserModel(profileImageUrl: nil,
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
    @Published var displayCrop = false
    
    @MainActor
    func convertDataToImage() {
        guard (selectedPhoto != nil) else { return }
        Task{
            if let imageData = try? await selectedPhoto!.loadTransferable(type: Data.self) {
                if let image = UIImage(data: imageData){
                    userBeforeCrop = image
                    displayCrop.toggle()
                }
            }
        }
    }
    
    func putCroppedImage(croppedImage: UIImage){
        isImageSelected = true
        userPhoto = croppedImage
        saveProfileImage()
    }
    
    func fetchProfile(){
        getDataCall {
            try await FirestorageManager.shared.fetchProfile()
        } onSuccess: { user in
            self.user = user
            self.loading = false
            self.matchProfile()
        } onLoading: {
            self.loading = true
        } onError: { error in
            self.loading = false
            self.error = error?.localizedDescription ?? ""
        }
    }
    
    private func matchProfile(){
        self.nameInput = self.user.name
        self.surnameInput = self.user.surname ?? ""
        self.mobileInput = self.user.phoneNumber ?? ""
        self.emailInput = self.user.email ?? ""
    }
    
    private func saveProfileImage() {
        guard let imageData = userPhoto?.jpegData(compressionQuality: 0.8) else { return }
        
        if let userUrl = self.user.profileImageUrl {
            Task{
                do{
                    try await FirestorageManager.shared.deleteImageAtURL(urlString: userUrl)
                }catch{
                    self.error = error.localizedDescription
                    print(self.error)
                    print("firebase hatan bu")
                }
            }
        }

        getDataCall {
            try await FirestorageManager.shared.addProfileImage(imageData: imageData)
        } onSuccess: { url in
            self.user.profileImageUrl = url
        } onLoading: {
            self.loading = true
        } onError: { error in
            self.error = error?.localizedDescription ?? ""
        }
    }
    
    func saveProfile(){
        getDataCall {
            try await FirestorageManager.shared.updateProfile(name: self.nameInput, surname: self.surnameInput, email: self.emailInput, phoneNumber: self.mobileInput)
        } onSuccess: {
            self.success = true
            self.loading = false
        } onLoading: {
            self.loading = true
        } onError: { error in
            self.loading = false
            self.error = error?.localizedDescription ?? ""
        }
    }
}
