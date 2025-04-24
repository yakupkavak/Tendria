//
//  TextStyles.swift
//  Tendria
//
//  Created by Yakup Kavak on 18.01.2025.
//

import Foundation
import SwiftUI

struct tvGradient: View {
    var text: LocalizedStringKey
    var gradientColors: [Color]
    var font: Font
    var fontWeight: Font.Weight
    
    var body: some View {
        Text(text)
            .font(font)
            .fontWeight(fontWeight)
            .overlay(
                LinearGradient(
                    gradient: Gradient(colors: gradientColors),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .mask(
                Text(text)
                    .font(font)
                    .fontWeight(fontWeight)
            )
    }
}
struct tvColorString: View {
    var text: String
    var color: Color
    var weight: Font.Weight? = .regular
    var font: Font
    
    var body: some View {
        Text(text)
            .font(font)
            .fontWeight(weight)
            .foregroundColor(color)
    }
}

struct tvColorKey: View {
    var text: LocalizedStringKey
    var color: Color
    var weight: Font.Weight? = .regular
    var font: Font
    var textAlignment: TextAlignment? = .center
    
    var body: some View {
        Text(text)
            .font(font)
            .fontWeight(weight)
            .foregroundColor(color)
            .multilineTextAlignment(textAlignment!)
    }
}

struct tvColorKeyString: View {
    var text: String
    var color: Color
    var weight: Font.Weight? = .regular
    var font: Font
    var textAlignment: TextAlignment? = .center
    
    var body: some View {
        Text(text)
            .font(font)
            .fontWeight(weight)
            .foregroundColor(color)
            .multilineTextAlignment(textAlignment!)
    }
}
