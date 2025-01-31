//
//  SignInUI.swift
//  Tendria
//
//  Created by Yakup Kavak on 18.01.2025.
//

import SwiftUI
import _AuthenticationServices_SwiftUI

struct SignInUI: View {
    
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var router: RouterSign
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack {
            VStack() {
                CustomWaveView(gradient: Gradient(colors: [Color.orange700, Color.red300]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(height: Height.mediumHeight)
                    .shadow(radius: Radius.normalRadius)
                Spacer()
            }
            .edgesIgnoringSafeArea(.top)//ekranın çentiklerini vs göz artı edip en yukarı çık
            
            VStack(spacing: Height.normalHeight) {
                Spacer().frame(height: Height.largeHeight)
                
                BigSizeBoldGrad(text: Strings.welcome)
                
                tvSubHeadline(text: Strings.signAccount, color: Color.blue500)
                
                VStack(spacing: Height.mediumHeight) {
                    tfIcon(iconSystemName: "person.fill", placeHolder: Strings.username, textInput: $username)
                    tfIcon(iconSystemName: "lock.fill", placeHolder: Strings.password, textInput: $password)
                }
                
                HStack {
                    Spacer()
                    btnText(customView: tvFootnote(text: Strings.forgotPassword, color: Color.red500)) {
                        router.navigate(to: .forgotPassword)
                    }
                }
                
                Spacer()
                
                HStack(spacing: Height.xSmallHeight){
                    Spacer()
                    tvHeadline(text: Strings.signIn, color: .blue500)
                    btnSystemIcon(iconSystemName: "arrow.right", color: .white) {
                        print("giriş yap tıklandı")
                    }
                }
            
                Spacer()
                Spacer()
                
                HStack {
                    tvFootnote(text: Strings.dontAccount, color: .primary)
                    btnText(customView: tvFootnote(text: Strings.create, color: Color.orange700)) {
                        router.navigate(to: .signUp)
                        
                    }
                }
                HStack(spacing: Height.xSmallHeight){
                    
                    SignInWithAppleButton { request in
                        AppleSignInManager.shared.requestAppleAuthorization(request)
                    } onCompletion: { result in
                        //handleAppleID(result)
                    }
                    btnSignIcon(iconName: "googleIcon") {
                        Task{
                            await signInWithGoogle()
                        }
                    }
                    
                }
                
                Spacer()
            }
            .padding(.horizontal, Height.normalHeight)
        }.navigationBarBackButtonHidden()
    }
    func signInWithGoogle() async {
        do {
            guard let user = try await GoogleSignInManager.shared.signInWithGoogle() else { return }

            let result = try await authManager.googleAuth(user)
            if let result = result {
                print("GoogleSignInSuccess: \(result.user.uid)")
                router.navigate(to: .feed)
            }
        }
        catch {
            print("GoogleSignInError: failed to sign in with Google, \(error))")
        }
    }
}

#Preview {
    SignInUI()
}
