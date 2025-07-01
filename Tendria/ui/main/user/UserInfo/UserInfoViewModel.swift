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
final class UserInfoViewModel: ObservableObject {
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
    
    func updateImage(){
        
    }
    
    func saveProfile(){
        
    }

}
