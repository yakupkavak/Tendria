//
//  ResetPasswordViewModel.swift
//  Tendria
//
//  Created by Yakup Kavak on 11.02.2025.
//

import Foundation

class ResetPasswordViewModel: BaseViewModel{
    @Published var success = false
    @Published var loading = false
    @Published var error = ""
    @Published var currentPassword = ""
    @Published var newPassword = ""
    @Published var againPassword = ""
    
    func changePassword() {
        
    }
}
