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
    @StateObject var viewModel: SignInViewModel
    
    init(authManager: AuthManager) {
        _viewModel = StateObject(wrappedValue: SignInViewModel(authManager: authManager))
    }
    
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
                
                BigSizeBoldGrad(text: StringKey.welcome)
                
                tvSubHeadline(text: StringKey.signAccount, color: Color.blue500)
                
                VStack(spacing: Height.mediumHeight) {
                    tfIcon(iconSystemName: IconName.envelope, placeHolder: StringKey.email, textInput: $viewModel.email)
                    tfIcon(iconSystemName: IconName.lock, placeHolder: StringKey.password, textInput: $viewModel.password)
                }
                
                HStack {
                    Spacer()
                    btnText(customView: tvFootnote(text: StringKey.forgotPassword, color: Color.red500)) {
                        router.navigate(to: .forgotPassword)
                    }
                }
                
                Spacer()
                
                HStack(spacing: Height.xSmallHeight){
                    Spacer()
                    tvHeadline(text: StringKey.signIn, color: .blue500)
                    btnSystemIcon(iconSystemName: IconName.right_arrow, color: .white) {
                        viewModel.signInEmail()
                    }
                }
            
                Spacer()
                Spacer()
                
                HStack {
                    tvFootnote(text: StringKey.dont_account, color: .primary)
                    btnText(customView: tvFootnote(text: StringKey.create, color: Color.orange700)) {
                        router.navigate(to: .signUp)
                        
                    }
                }
                HStack(spacing: Height.xSmallHeight){
                    btnSignIcon(iconName: IconName.appleIcon) {
                        Task{
                            viewModel.signInWithApple()
                        }
                    }
                    btnSignIcon(iconName: IconName.googleIcon) {
                        Task{
                            viewModel.signInWithGoogle()
                        }
                    }
                }
                Spacer()
            }
            .padding(.horizontal, Height.normalHeight)
        }.navigationBarBackButtonHidden()
            .onChange(of: viewModel.success) {
                if viewModel.success {
                    print("✅ Giriş başarılı! Ana ekrana yönlendiriliyor...")
                    router.navigate(to: .feed)
                }
            }
            .onChange(of: viewModel.error) {
                if !viewModel.error.isEmpty {
                    print("❌ Hata oluştu: \(viewModel.error)")
                }
            }.alert(StringKey.error, isPresented: $viewModel.showAllert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.error)
            }
    }
}

#Preview {
    let previewAuthManager = AuthManager() // Geçici bir AuthManager oluştur
    return SignInUI(authManager: previewAuthManager)
        .environmentObject(previewAuthManager) // Preview için environmentObject ver
}
