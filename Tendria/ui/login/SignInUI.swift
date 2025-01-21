//
//  SignInUI.swift
//  Tendria
//
//  Created by Yakup Kavak on 18.01.2025.
//

import SwiftUI

struct SignInUI: View {
    
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
                    btnIcon(iconSystemName: "arrow.right", color: .white) {
                        print("giriş yap tıklandı")
                    }
                }
                
                Spacer()
                
                HStack {
                    tvFootnote(text: Strings.dontAccount, color: .primary)
                    btnText(customView: tvFootnote(text: Strings.create, color: Color.orange700)) {
                        router.navigate(to: .signUp)
                        
                    }
                }
                Spacer()
            }
            .padding(.horizontal, Height.normalHeight)
        }.navigationBarBackButtonHidden()
    }
}

#Preview {
    SignInUI()
}
