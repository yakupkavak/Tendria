//
//  UserInfoUI.swift
//  Tendria
//
//  Created by Yakup Kavak on 11.02.2025.
//

import SwiftUI
import _PhotosUI_SwiftUI
import Kingfisher
import SwiftyCrop

struct UserInfoUI: View {
    
    @EnvironmentObject var routerUser: RouterUserInfo
    @StateObject private var viewModel = UserInfoViewModel()
    @State private var displayCrop = false
    
    var body: some View {
        VStack(spacing: 16){
            
            KFImage.profile(viewModel.user.profileImageUrl, size: 150).overlay(alignment: .bottomTrailing) {
                btnAddIcon(iconName: "plus",width: 35) {
                    print("yakup")
                }
            }
            
            
            Spacer()
            tvBodyline(text: StringKey.yourInfo, color: .blue500).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom)
            
            VStack(alignment: .leading){
                tvFootnote(text: StringKey.name, color: .black).padding(.leading)
                tfText(placeHolder: StringKey.accept, textInput: $viewModel.nameInput)
            }
            VStack(alignment: .leading){
                tvFootnote(text: StringKey.surname, color: .black).padding(.leading)
                tfText(placeHolder: StringKey.accept, textInput: $viewModel.surnameInput)
            }
            VStack(alignment: .leading){
                tvFootnote(text: StringKey.mobile, color: .black).padding(.leading)
                tfText(placeHolder: StringKey.accept, keyboard: .phonePad, textInput: $viewModel.mobileInput)
            }
            VStack(alignment: .leading){
                tvFootnote(text: StringKey.email, color: .black).padding(.leading)
                tfText(placeHolder: StringKey.accept, keyboard: .emailAddress, textInput: $viewModel.emailInput)
            }
            
            btnTextGradientInfinity(action: {
                print("y")
            }, text: StringKey.accept).padding(.top)
            Spacer()
        }.padding()
            .navigateBackView(onClick: routerUser.navigateBack)
            .cropImage(displayCrop: $displayCrop, beforeCropImage: viewModel.userBeforeCrop, onFinish: { cropImage in viewModel.putCroppedImage(croppedImage:cropImage)}, maskShape: .circle, maskRadius: 200, zoomSensitivity: 10)
    }
}

#Preview {
    UserInfoUI()
}
