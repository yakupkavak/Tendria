//
//  TaskRowUI.swift
//  Tendria
//
//  Created by Yakup Kavak on 3.02.2025.
//

import SwiftUI

struct CollectionRowUI: View {
    var url: String
    var subText: String
    var shouldCancelOnDisappear: Bool
    var body: some View {
        VStack(alignment: .leading,spacing: .zero){
            RowURLImage(imageUrl: url,shouldCancelOnDisappear: shouldCancelOnDisappear)
            tvRowSubline(text: subText)
        }.background(Color.white).clipShape(RoundedRectangle(cornerRadius: Radius.mediumRadius)).shadow(radius: Radius.shadowSmallRadius)
    }
}

#Preview {
    CollectionRowUI(url: "https://dragonball.guru/wp-content/uploads/2021/03/goku-profile-e1616173641804-400x400.png", subText: "goku", shouldCancelOnDisappear: true)
}
