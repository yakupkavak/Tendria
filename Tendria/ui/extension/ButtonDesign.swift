//
//  ButtonDesign.swift
//  Tendria
//
//  Created by Yakup Kavak on 20.01.2025.
//

import Foundation
import SwiftUI

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
struct btnIcon: View {
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
