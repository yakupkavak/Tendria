//
//  UserInfoUI.swift
//  Tendria
//
//  Created by Yakup Kavak on 11.02.2025.
//

import SwiftUI
import _PhotosUI_SwiftUI
import Kingfisher

struct UserInfoUI: View {
    
    @EnvironmentObject var routerBase: RouterUserInfo
    @StateObject private var viewModel = UserInfoViewModel()
    
    var body: some View {
        VStack(spacing: 16){
            tvFootnote(text: StringKey.category, color: .brown300)
            KFImage.profile(viewModel.user.profileImageUrl, size: 150).overlay(alignment: .bottomTrailing) {
                btnAddIcon(iconName: "plus",width: 35) {
                    print("yakup")
                }
            }
        
            Spacer()
            tvBodyline(text: StringKey.category, color: .blue500).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom)
            
            VStack(alignment: .leading){
                tvFootnote(text: StringKey.accept, color: .black).padding(.leading)
                tfText(placeHolder: StringKey.accept, textInput: $viewModel.nameInput)
            }
            VStack(alignment: .leading){
                tvFootnote(text: StringKey.accept, color: .black).padding(.leading)
                tfText(placeHolder: StringKey.accept, textInput: $viewModel.surnameInput)
            }
            VStack(alignment: .leading){
                tvFootnote(text: StringKey.accept, color: .black).padding(.leading)
                tfText(placeHolder: StringKey.accept, keyboard: .phonePad, textInput: $viewModel.mobileInput)
            }
            VStack(alignment: .leading){
                tvFootnote(text: StringKey.accept, color: .black).padding(.leading)
                tfText(placeHolder: StringKey.accept, keyboard: .emailAddress, textInput: $viewModel.emailInput)
            }
            Spacer()
            Spacer()
            btnTextGradientInfinity(action: {
                print("y")
            }, text: StringKey.accept)
        }.padding()
    }
}

#Preview {
    UserInfoUI()
}
