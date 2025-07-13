//
//  ResetPasswordUI.swift
//  Tendria
//
//  Created by Yakup Kavak on 11.02.2025.
//

import SwiftUI

struct ResetPasswordUI: View {
    
    @EnvironmentObject var routerUser: RouterUserInfo
    @StateObject var viewModel = ResetPasswordViewModel()
    
    var body: some View {
        VStack(alignment: .leading){
            Spacer()
            tvHeadline(text: StringKey.change_password, color: .blue500)
            Spacer()
            tvColorKey(text: StringKey.current_password, color: .blue500, font: .callout)
            tfText(placeHolder: StringKey.name_placeholder, textInput: $viewModel.currentPassword)
            
            tvColorKey(text: StringKey.new_password, color: .blue500, font: .callout)
            tfText(placeHolder: StringKey.name_placeholder, textInput: $viewModel.newPassword)
            
            tvColorKey(text: StringKey.again_password, color: .blue500, font: .callout)
            tfText(placeHolder: StringKey.name_placeholder, textInput: $viewModel.againPassword)
            Spacer()
        }.padding(Padding.constantMediumPadding)
    }
}

#Preview {
    ResetPasswordUI()
}
