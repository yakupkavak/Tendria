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
        .cornerRadius(radius.xLargeRadius)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}
struct tfText: View {
    
    var placeHolder: LocalizedStringKey
    @Binding var textInput: String
    
    var body: some View {
        TextField(placeHolder, text: $textInput)
            .autocapitalization(.none)
            .textFieldStyle(PlainTextFieldStyle())
        .padding()
        .background(Color.white)
        .cornerRadius(radius.xLargeRadius)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}
struct teText: View {
    
    var placeHolder: LocalizedStringKey
    @Binding var textInput: String
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $textInput)
                .autocapitalization(.none)
                .textFieldStyle(PlainTextFieldStyle())
                .focused($isFocused)
                .frame(alignment: .top)
                .padding(.leading, 10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 0)
                    )
                    .background(Color.white)
            Text(placeHolder).frame(alignment: .leading)
                .foregroundColor(Color(.systemGray2))
                .padding()
                .opacity(self.textInput == "" ? 100 : 0)
                .onTapGesture {
                    isFocused = true
                }
        }
        .cornerRadius(radius.mediumRadius)
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}
    
struct tfTextCopy: View {
    
    var placeHolder: String
    @Binding var textInput: String
    @Binding var showCopyButton: Bool
    @Binding var isEditable: Bool
    
    @State private var isCopied: Bool = false // Kopyalandığında animasyon tetiklenecek
    
    var body: some View {
        HStack {
            TextField(placeHolder, text: $textInput)
                .disabled(!isEditable)
                .autocapitalization(.none)
                .textFieldStyle(PlainTextFieldStyle())
                .padding()
                .multilineTextAlignment(.center)
            
            // Kopyalama butonu
            if showCopyButton {
                Button(action: {
                    copyToClipboard()
                    UIPasteboard.general.string = textInput
                    ShareManager.shareCode(textInput)
                }) {
                    Image(systemName: isCopied ? "checkmark.circle.fill" : "doc.on.doc") // Animasyon için ikon değişimi
                        .foregroundColor(isCopied ? .green : .gray)
                        .transition(.scale) // Butonun boyut değiştirme animasyonu
                }
                .padding(.trailing, 10)
            }
        }.frame(width: TextWith.tfNormalWidth)
        .background(Color.white)
        .cornerRadius(Radius.mediumRadius)
        .shadow(color: Color.black.opacity(0.1), radius: Radius.shadowRadius, x: 0, y: 5)
    }
    
    private func copyToClipboard() {
        UIPasteboard.general.string = textInput
        withAnimation(.easeInOut(duration: 0.3)) {
            isCopied = true
        }
        
        // Animasyonun geri dönmesi için 1 saniye sonra eski haline getiriyoruz
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation {
                isCopied = false
            }
        }
    }
}

#Preview {
    @State var text: String = "SwiftUI Harika!"
    @State var text2: String = ""
    @State var edit: Bool = true
    @State var show: Bool = true
    teText(placeHolder: StringKey.add_collection, textInput: $text2)

    tfTextCopy(placeHolder: StringValues.RELATION_CODE_PLACEHOLDER, textInput: $text, showCopyButton: $show, isEditable: $edit)
    
}
