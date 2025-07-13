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
    }
}

struct MemoryImage: View {
    var imageUrl: String
    var shouldCancelOnDisappear: Bool = false
    
    @State private var imageSize: CGSize?
    var body: some View {
        KFImage(URL(string: imageUrl)!)
            .resizable()
            .placeholder {
                ShimmerEffectBox()
            }
            .retry(maxCount: 3, interval: .seconds(5))
            .onSuccess { r in
                // r: RetrieveImageResult
            }
            .onFailure { e in
                // e: KingfisherError
                print("failure: \(e)")
            }.cancelOnDisappear(shouldCancelOnDisappear).aspectRatio(contentMode: .fit)
           
    }
}
extension KFImage {
    static func profile(
        urlString: String?,
        size: CGFloat
    ) -> some View {
        let swiftUIImage = Image("avatar_placeholder")
            .resizable()

        let uiImage = UIImage(named: "avatar_placeholder")

        guard
            let urlString,
            !urlString.isEmpty,
            let url = URL(string: urlString)
        else {
            return AnyView(
                swiftUIImage
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .clipShape(Circle())
                    .shadow(radius: Radius.shadowRadius)
            )
        }

        return AnyView(
            KFImage(url)
                .placeholder { swiftUIImage }
                .onFailureImage(uiImage)
                .resizable()
                .scaledToFill()
                .frame(width: size, height: size)
                .clipShape(Circle())
                .shadow(radius: Radius.shadowRadius)
        )
    }
}

struct UploadImageSequenceUI: View {
    var uiImage: UIImage
    var maxHeight: CGFloat
    var maxWidth: CGFloat
    
    var body: some View {
        Image(uiImage: uiImage).resizable()
            .frame(width: maxWidth,height: maxHeight).clipShape(RoundedRectangle(cornerRadius: Radius.mediumRadius))
            .scaledToFit()
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
    /*
    @State var isSelected = true
    @State var fetchedImageSize: CGSize()
    /*
    CustomLottieView(animationFileName: LottieSet.HEART_LOADING, isDotLottieFile: false, loopMode: .autoReverse)*/
    MemoryImage(imageUrl: "https://static.wikia.nocookie.net/dragon-ball-turkiye/images/e/e4/Goku_arrives_colored.PNG/revision/latest/scale-to-width/360?cb=20240328182720&path-prefix=tr")
    */
}
