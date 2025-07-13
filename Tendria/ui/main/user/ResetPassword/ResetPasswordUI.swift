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
        VStack(alignment: .leading,spacing: Padding.constantNormalPadding){
            tvHeadline(text: StringKey.change_password, color: .blue500).padding(.top)
            Spacer()
            tvColorKey(text: StringKey.current_password, color: .blue500, font: .callout)
            tfText(placeHolder: StringKey.empty, textInput: $viewModel.currentPassword)
            
            tvColorKey(text: StringKey.new_password, color: .blue500, font: .callout).padding(.top)
            tfText(placeHolder: StringKey.empty, textInput: $viewModel.newPassword)
            
            tvColorKey(text: StringKey.again_password, color: .blue500, font: .callout).padding(.top)
            tfText(placeHolder: StringKey.empty, textInput: $viewModel.againPassword)
            Spacer()
            if let error = viewModel.error {
                Text(error.errorDescription)
                    .foregroundColor(.red)
                    .font(.subheadline)
                    .padding(.bottom, 12)
            }
            if (viewModel.success){
                Text(StringKey.success)
                    .foregroundColor(.green)
                    .font(.subheadline)
                    .padding(.bottom, 12)
            }
            btnTextGradientInfinity(action: {
                viewModel.resetPassword()
            }, text: StringKey.update).padding(.top)
            Spacer()
            
            Spacer()
        }.padding(Padding.constantMediumPadding)
    }
}

#Preview {
    ResetPasswordUI()
}
