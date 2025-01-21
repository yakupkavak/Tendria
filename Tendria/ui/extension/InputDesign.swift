//
//  InputDesign.swift
//  Tendria
//
//  Created by Yakup Kavak on 19.01.2025.
//

import Foundation
import SwiftUI
typealias radius = Constants.Radius

struct tfIcon: View {
    var iconSystemName: String
    var placeHolder: LocalizedStringKey
    @Binding var textInput: String
    
    var body: some View {
        HStack {
            Image(systemName: iconSystemName)
                .foregroundColor(.gray)
                .frame(width: Height.smallIconHeight, height: Height.smallIconHeight, alignment: .center)
            TextField(placeHolder, text: $textInput)
                .autocapitalization(.none)
                .textFieldStyle(PlainTextFieldStyle())
        }
        .padding()
        .background(Color.white)
        .cornerRadius(radius.largeRadius)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}
