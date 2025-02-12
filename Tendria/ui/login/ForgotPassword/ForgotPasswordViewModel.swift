//
//  ForgotPasswordViewModel.swift
//  Tendria
//
//  Created by Yakup Kavak on 21.01.2025.
//

import Foundation

class ForgotPasswordViewModel: BaseViewModel{
    @Published var email = ""
    @Published var success = ""
    @Published var loading : Bool = false
    @Published var error = ""
    @Published var showAllert: Bool = false
    @Published var alertType: AlertType = .success

    func forgotPassword(){
        getDataCall {
            try await AuthManager.shared.resetPassword(email: self.email)
        } onSuccess: { result in
            self.showAllert = true
            self.alertType = .success
            self.success = getLocalizedString(StringKey.password_reset_success)
            self.loading = false
        } onLoading: {
            self.loading = true
        } onError: { error in
            self.alertType = .error
            self.loading = false
            self.showAllert = true
            self.error = error?.localizedDescription ?? String(describing: StringKey.unknown_error)
        }
    }
}
