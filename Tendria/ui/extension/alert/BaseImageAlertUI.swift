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
    var title: LocalizedStringKey = StringKey.notification
    var message: LocalizedStringKey = StringKey.notification_subtext
    var onSuccessText: LocalizedStringKey = StringKey.turn_on
    var onDeniedText: LocalizedStringKey = StringKey.skip_for_now
    var onSuccess: () -> Void
    var onDenied: () -> Void
    let opacity = 0.6
    var body: some View {
        ZStack{
            Color.gray.opacity(opacity).ignoresSafeArea()
            VStack(spacing: Spacing.normalSpacing) {
                ImageAsset(uiImageSource: uiImageSource).frame(height: Height.mediumPlusHeight)
                tvHeadline(text: title, color: .blue500)
                tvColorKey(text: message, color: .subTextGray, font: .callout).padding(.horizontal,Padding.constantMinusMediumPadding)
                
                VStack(spacing: Spacing.normalSpacing) {
                    btnTextGradient(shadow: 0, action: {
                        onSuccess()
                    }, text: onSuccessText)
                    btnTextTransparent(
                        action: {onDenied()},
                        text: onDeniedText)
                }
            }
            .padding(.all, Padding.constantMediumPadding)
            .padding(.horizontal, Padding.horizontalXSmallPadding)
            .background(Color.white)
            .cornerRadius(Radius.mediumRadius)
            .frame(maxWidth: Padding.constantXLargePadding)
        }.ignoresSafeArea()
        .zIndex(.greatestFiniteMagnitude)
    }
}
#Preview {
    @State var isPres = true
    BaseImageAlertUI(onSuccess: {
        print("yakup")
    },onDenied: {
        print("yakup")
    })
}
