//
//  ButtonDesign.swift
//  Tendria
//
//  Created by Yakup Kavak on 20.01.2025.
//

import Foundation
import SwiftUI
import SVGKit

struct btnOnlyText<Content: View>: View {
    var customView: Content
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            customView
        }
    }
}
struct btnSystemIcon: View {
    var iconSystemName: String
    var color: Color
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: iconSystemName).foregroundColor(color)
        }.btnStyle()
    }
}
struct btnSignIcon: View {
    var iconName: String
    var width: CGFloat? = IconWidth.mediumHeight
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(iconName).resizable().scaledToFit()
                .frame(width: width,height: width)
        }
    }
}
struct btnAddIcon: View {
    var iconName: String
    var backgroundColor: Color? = Color.orange500
    var foregroundColor: Color? = Color.white
    var shadow: CGFloat? = IconWidth.smallHeight
    var width: CGFloat? = IconWidth.normalHeight
    var paddingWidth: CGFloat? = IconWidth.smallHeight

    var action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: iconName)
                .resizable()
                .scaledToFit()
                .font(.system(size: 16, weight: .heavy))
                .scaleEffect(0.7)
                .padding(paddingWidth!)
                .gradientBackground() //padding önce olmalı background algılamaz.
                .frame(width: width,height: width)
                .foregroundColor(foregroundColor)
                .clipShape(Circle())
                .shadow(radius: shadow!)
        }
    }
}
struct btnText: View {
    
    var backgroundColor: Color? = Color.orange500
    var foregroundColor: Color? = Color.btnForeground
    var shadow: CGFloat? = IconWidth.smallHeight
    var action: () -> Void
    var text: LocalizedStringKey
    
    var body: some View {
        Button {
            action()
        } label: {
            tvHeadline(text: text, color: .btnForeground).frame(maxWidth: .infinity).padding().gradientBackground().clipShape(RoundedRectangle(cornerRadius: Radius.mediumRadius)).shadow(radius: shadow!)
        }
    }
}

#Preview{
    btnText(action: {
        print("yakup")
    }, text: StringKey.add )
}
