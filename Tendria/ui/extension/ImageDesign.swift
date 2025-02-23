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
                    .frame(height: Height.xxLargeHeight)
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
            .frame(height: Height.xxLargeHeight)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: Radius.mediumRadius))
    }
}

struct ImageAsset: View {
    
    var uiImageSource: String
    var imageHeight: CGFloat? = ImageWidth.largeWidth
    private var image: UIImage
    
    init(uiImageSource: String) {
        self.uiImageSource = uiImageSource
        self.image = UIImage(named: uiImageSource) ?? UIImage()
    }

    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .frame(width: imageHeight)
            .clipped()
            
    }
}

#Preview {
    ImageAsset(uiImageSource: ImageSet.MAKE_RELATION)
}
