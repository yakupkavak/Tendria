//
//  ImageDesign.swift
//  Tendria
//
//  Created by Yakup Kavak on 4.02.2025.
//

import Foundation
import SwiftUI

struct RowImage: View {
    
    var body: some View {
        Image("pikachu").resizable().scaledToFill().frame(width: .infinity,height: Height.xLargeHeight).clipped()
    }
}

#Preview {
    RowImage()
}
