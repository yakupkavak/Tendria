//
//  ImageDesign.swift
//  Tendria
//
//  Created by Yakup Kavak on 4.02.2025.
//

import Foundation
import SwiftUI

struct RowURLImage: View {
    
    var imageUrl: String
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: Height.xLargeHeight)
                    .clipped()
            case .failure:
                Text("Görsel yüklenemedi")
                    .foregroundColor(.red)
            case .empty:
                ProgressView() // Yükleme devam ediyorsa göster
            @unknown default:
                EmptyView()
            }
        }
    }
}
struct RowUIImage: View {
    
    var uiImage: UIImage
        
    var body: some View {
        Image(uiImage: uiImage)
            .resizable()
            .scaledToFit()
            .frame(height: Height.xLargeHeight)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: Radius.mediumRadius))
    }
}

#Preview {
    RowURLImage(imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjzJjPa-3jdL6XAI0yqXBY8VzK_p5h0yQIkQ&s")
}
