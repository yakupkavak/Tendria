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

struct UploadImageUI: View {
    var uiImage: UIImage
    var height: CGFloat = Height.xxLargeHeight
    var width: CGFloat = Width.screenHalfWidth
    var unSelectedHeight: CGFloat = Height.xxLargeHeight
    @Binding var isImageSelected: Bool
    
    var body: some View {
        if(isImageSelected){
            Image(uiImage: uiImage).findTrueSize(uiImage: uiImage, maxHeight: height, maxWidth: width)
        }else {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .frame(height: unSelectedHeight)
                .clipShape(RoundedRectangle(cornerRadius: Radius.mediumRadius))
        }
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
