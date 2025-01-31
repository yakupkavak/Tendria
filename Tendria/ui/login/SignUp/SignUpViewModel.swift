//
//  SignUpViewModel.swift
//  Tendria
//
//  Created by Yakup Kavak on 21.01.2025.
//

import Foundation
import Combine
import SwiftUI
import AuthenticationServices

class SignUpViewModel: BaseViewModel {
    @Published var userName = ""
    @Published var fullName = ""
    @Published var password = ""
    @Published var email = ""
    @Published var success : Bool = false
    @Published var loading : Bool = false
    @Published var error = ""
    
    private var authManager: AuthManager
    
    init(authManager: AuthManager) {
        self.authManager = authManager
    }
    
    func signUpEmail() {
        Task {
            do{
                try await authManager.signOut()
            }catch{
                print("")
            }
        }
        
        guard !email.isEmpty, !password.isEmpty else {
            self.error = "E-posta ve şifre boş olamaz."
            return
        }
        getDataCall(
            dataCall: { try await self.authManager.signUpWithEmail(email: self.email, password: self.password)},
            onSuccess: { result in
                self.success = true
                self.loading = false
            },
            onLoading: {self.loading = true},
            onError: {error in
                self.error = error?.localizedDescription ?? String(describing: Strings.unknown_error)
                self.loading = false
            }
        )
    }
    
    func signInWithGoogle(onSucces: @escaping () -> Void) {
        
        getDataCall {
            guard let user = try await GoogleSignInManager.shared.signInWithGoogle() else {
                throw NSError(domain: "GoogleSignIn", code: -1, userInfo: [NSLocalizedDescriptionKey: "Google giriş başarısız"])
            }
            return try await self.authManager.googleAuth(user)
        } onSuccess: { result in
            if let result = result {
                self.loading = false
                print("GoogleSignInSuccess: \(result.user.uid)")
                onSucces()
            }
        } onLoading: {
            self.loading = true
        } onError: { error in
            self.error = error?.localizedDescription ?? String(describing: Strings.unknown_error)
            self.loading = false
        }
    }
    func signInWithApple(onSucces: @escaping () -> Void){
        getDataCall {
            return try await withCheckedThrowingContinuation { continuation in
                AppleSignInDelegate.shared.completion = { result in
                        switch result {
                        case .success(let authorization):
                            continuation.resume(returning: result) // ✅ Burada sadece `ASAuthorization` dönüyoruz.
                        case .failure(let error):
                            continuation.resume(throwing: error) // ✅ Burada sadece hata fırlatıyoruz.
                        }
                    }
                AppleSignInManager.shared.startSignInAppleFlow()
            }
            
        } onSuccess: { result in
            self.handleAppleID(result, onSucces: onSucces)
        } onLoading: {
            self.loading = true
        } onError: { error in
            self.error = error?.localizedDescription ?? String(describing: Strings.unknown_error)
            self.loading = false
        }

    }
    
    private func handleAppleID(_ result: Result<ASAuthorization, Error>,onSucces: @escaping () -> Void) {
        if case let .success(auth) = result {
            guard let appleIDCredentials = auth.credential as? ASAuthorizationAppleIDCredential else {
                print("AppleAuthorization failed: AppleID credential not available")
                return
            }

            Task {
                do {
                    let result = try await authManager.appleAuth(
                        appleIDCredentials,
                        nonce: AppleSignInManager.nonce
                    )
                    if result != nil {
                        onSucces()
                    }
                } catch {
                    print("AppleAuthorization failed: \(error)")
                    // Here you can show error message to user.
                }
            }
        }
        else if case let .failure(error) = result {
            print("AppleAuthorization failed: \(error)")
            // Here you can show error message to user.
        }
    }
    
}
