//
//  ExtensionUI.swift
//  Tendria
//
//  Created by Yakup Kavak on 20.01.2025.
//

import Foundation
import SwiftUI
extension View {
    func normalShadow() -> some View {
        self.shadow(color: Color.black.opacity(0.2), radius: Constants.Radius.shadowRadius, x: 0, y: 5)
    }
    func gradientBackground() -> some View{
        self.background(LinearGradient(
            gradient: Gradient(colors: [
                Color.orange700, Color.red300]),
            startPoint: .leading,
            endPoint: .trailing
        ))
    }
    func customPadding(horizontal: CGFloat, vertical: CGFloat) -> some View {
        self
            .padding(.horizontal, horizontal)
            .padding(.vertical, vertical)
    }
    func btnStyle() -> some View{
        self.customPadding(horizontal: Padding.mediumPadding, vertical: Padding.smallPadding).gradientBackground().normalShadow().cornerRadius(Constants.Radius.xLargeRadius)
    }
}
