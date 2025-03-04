//
//  CloudMessageAlert.swift
//  Tendria
//
//  Created by Yakup Kavak on 1.03.2025.
//

import Foundation
import SwiftUICore
import SwiftUI

struct BaseImageAlertUI: View {
        
    var uiImageSource: String = ImageSet.NOTIFICATION
    @Binding var isPresented: Bool
    var title: LocalizedStringKey = StringKey.notification
    var message: LocalizedStringKey = StringKey.notification_subtext
    var onSuccessText: LocalizedStringKey = StringKey.turn_on
    var onDeniedText: LocalizedStringKey = StringKey.skip_for_now
    var onSuccess: () -> Void
    var onDenied: () -> Void
    
    var body: some View {
        ZStack{
            Color.gray.ignoresSafeArea().opacity(isPresented ? 0.6 : 0)
            VStack(spacing: Spacing.normalSpacing) {
                ImageAsset(uiImageSource: uiImageSource).frame(height: Height.mediumPlusHeight)
                tvHeadline(text: title, color: .blue500)
                tvColorKey(text: message, color: .subTextGray, font: .callout)
                
                VStack(spacing: Spacing.normalSpacing) {
                    btnTextGradient(shadow: 0, action: {
                        onSuccess()
                        self.isPresented = false
                    }, text: onSuccessText)
                    btnTextTransparent(
                        action: {onDenied();self.isPresented = false},
                        text: onDeniedText)
                }
            }
            .padding()
            .padding(.horizontal, Padding.horizontalNormalPadding)
            .background(Color.white)
            .cornerRadius(Radius.mediumRadius)
            .frame(maxWidth: .infinity)
        }.ignoresSafeArea()
        .zIndex(.greatestFiniteMagnitude)
    }
}
#Preview {
    @State var isPres = true
    BaseImageAlertUI(isPresented: $isPres, onSuccess: {
        print("yakup")
    },onDenied: {
        print("yakup")
    })
}
