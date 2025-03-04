//
//  MakeRelationUI.swift
//  Tendria
//
//  Created by Yakup Kavak on 11.02.2025.
//

import SwiftUI

struct MakeRelationUI: View {
    
    @EnvironmentObject var routerUser: RouterUserInfo
    @EnvironmentObject var notificationManager: NotificationManager
    @StateObject private var viewModel = MakeRelationViewModel()
    
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                HStack{
                    tvHeadline(text: StringKey.create_relation_title, color: .blue500).frame(width: TextWith.titleWidth)
                    Spacer()
                }
                
                DoubleSpacer()
                ImageAsset(uiImageSource: ImageSet.MAKE_RELATION)
                
                DoubleSpacer()

                tfTextCopy(placeHolder: StringValues.RELATION_CODE_PLACEHOLDER, textInput: $viewModel.inputText, showCopyButton: $viewModel.showCopy, isEditable: $viewModel.isEditable)
                Spacer()
                
                tvColorKey(text: StringKey.choose_one, color: .blue500, font: .subheadline)
                
                Spacer()
                
                HStack{
                    //Generate Button
                    btnTextGradient(action: {
                        viewModel.generateCode()
                    }, text: StringKey.generate_code).frame(width: Width.buttonMediumWidth)
                    
                    Spacer()
                    
                    //Check Button
                    btnTextGradient(action: {
                        viewModel.checkCode()
                    }, text: StringKey.enter_code).frame(width: Width.buttonMediumWidth)
                    
                }
                Spacer()
            }.paddingHorizontal(value: Padding.horizontalNormalPadding)
                .customImageAlert(isPresent: notificationManager.permissionBinding) {
                    Task{
                        await notificationManager.request(requestType: .requestNotification)
                    }
                } onDenied: {
                    print("on denied")
                }
        }
    }
}
/*
 #Preview {
     MakeRelationUI(notificationManager: NotificationManager())
 }
 */
