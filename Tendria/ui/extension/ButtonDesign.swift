//
//  ButtonDesign.swift
//  Tendria
//
//  Created by Yakup Kavak on 20.01.2025.
//

import Foundation
import SwiftUI
import SVGKit

struct btnText<Content: View>: View {
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
                .frame(width: Constants.Icon.mediumHeight,height:Constants.Icon.mediumHeight)
        }
    }
}
