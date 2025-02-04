//
//  style.swift
//  Tendria
//
//  Created by Yakup Kavak on 19.01.2025.
//

import Foundation
import SwiftUI

struct BigSizeBoldGrad: View {
    var text: LocalizedStringKey
    var body: some View{
        tvGradient(text: text, gradientColors: Constants.Gradients.mediumOrangeRed, font: .largeTitle, fontWeight: .bold)
    }
}

struct tvFootnote: View {
    var text: LocalizedStringKey
    var color: Color
    var body: some View {
        tvColorKey(text: text, color: color, weight: .regular, font: .footnote)
    }
}

struct tvSubHeadline: View {
    var text: LocalizedStringKey
    var color: Color
    var body: some View {
        tvColorKey(text: text, color: color, weight: .regular, font: .subheadline)
    }
}

struct tvHeadline: View {
    var text: LocalizedStringKey
    var color: Color
    var body: some View {
        tvColorKey(text: text, color: color, weight: .bold, font: .title3)
    }
}

struct tvRowSubline: View {
    var text: String
    var body: some View {
        tvColorString(text: text, color: Color.blue500, weight: .bold, font: .system(size: 30)).padding(.leading, Height.normalHeight)
            .padding(.vertical, Height.xxSmallHeight)
    }
}
