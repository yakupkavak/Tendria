//
//  TaskRowUI.swift
//  Tendria
//
//  Created by Yakup Kavak on 3.02.2025.
//

import SwiftUI

struct TaskRowUI: View {
    var text: String
    var body: some View {
        VStack(alignment: .leading,spacing: .zero){
            RowImage()
            tvRowSubline(text: "Pikachu")
        }.background(Color.white).clipShape(.buttonBorder).shadow(radius: 2)
    }
}

#Preview {
    var text = "Şarap"
    TaskRowUI(text: text)
}
