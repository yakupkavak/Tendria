import SwiftUI
import Lottie

struct CustomLottieView: View {
    var animationFileName: String
    var isDotLottieFile: Bool
    let loopMode: LottieLoopMode

    var body: some View {
        LottieView(animation: .named(animationFileName)).playing(loopMode: loopMode)
    }
}

#Preview {
    CustomLottieView(animationFileName: LottieSet.BEAR_CAT_JSON, isDotLottieFile: true, loopMode: LottieLoopMode.loop)
}
