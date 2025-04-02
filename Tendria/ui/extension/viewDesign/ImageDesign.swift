//
//  ImageDesign.swift
//  Tendria
//
//  Created by Yakup Kavak on 4.02.2025.
//

import Foundation
import SwiftUI
import Kingfisher

struct RowURLImage: View {
    
    var imageUrl: String
    var height: CGFloat = Height.xxLargeHeight
    var shouldCancelOnDisappear: Bool
    var body: some View {
        KFImage(URL(string: imageUrl)!)
            .resizable()
            .placeholder {
                ShimmerEffectBox()
            }
            .retry(maxCount: 3, interval: .seconds(5))
            .onSuccess { r in
                // r: RetrieveImageResult
                print("success: \(r)")
            }
            .onFailure { e in
                // e: KingfisherError
                print("failure: \(e)")
            }.cancelOnDisappear(shouldCancelOnDisappear)
            .frame(height: height)
            .scaledToFit()
        /*
        AsyncImage(url: URL(string: imageUrl)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: height)
                    .clipped()
            case .failure(let error):
                ShimmerEffectBox()
                    .frame(height: height).onAppear {
                        print("hata bu -> \(error)")
                    }
            case .empty:
                ShimmerEffectBox()
                    .frame(height: height)
            @unknown default:
                EmptyView()
            }
        }
         */
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
    CustomLottieView(animationFileName: LottieSet.HEART_LOADING, isDotLottieFile: false, loopMode: .autoReverse)
}
