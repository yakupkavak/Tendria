//
//  TaskRowUI.swift
//  Tendria
//
//  Created by Yakup Kavak on 3.02.2025.
//

import SwiftUI

struct TaskRowUI: View {
    var url: String
    var subText: String
    var body: some View {
        VStack(alignment: .leading,spacing: .zero){
            RowImage(imageUrl: url)
            tvRowSubline(text: subText)
        }.background(Color.white).clipShape(.buttonBorder).shadow(radius: 2)
    }
}

#Preview {
    TaskRowUI(url: "https://dragonball.guru/wp-content/uploads/2021/03/goku-profile-e1616173641804-400x400.png", subText: "goku")
}
