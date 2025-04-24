//
//  UserManager.swift
//  Tendria
//
//  Created by Yakup Kavak on 12.02.2025.
//

import Foundation
import SwiftUICore

class UserManager: ObservableObject {
    
    @Published var userInstance: UserModel?
     
    static let shared = UserManager()
    
    private init() {}
    
    func getUserData(){
        guard let userId = AuthManager.shared.getUserID() else {
            return
        }
        FirestorageManager.shared
    }
}
