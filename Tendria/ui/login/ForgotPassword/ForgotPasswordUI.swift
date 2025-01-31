import SwiftUI

struct ForgotPasswordUI: View {
    
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject private var router: RouterSign
    @ObservedObject var viewModel = ForgotPasswordViewModel()
    
    var body: some View {
        ZStack {
            VStack() {
                CustomWaveView(gradient: Gradient(colors: [Color.orange700, Color.red300]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(height: Height.mediumHeight)
                    .shadow(radius: Radius.normalRadius)
                Spacer()
            }
            .edgesIgnoringSafeArea(.top)//ekranın çentiklerini vs göz artı edip en yukarı çık
            
            VStack(spacing: Height.mediumHeight) {
                Spacer().frame(height: Height.mediumHeight)
                
                BigSizeBoldGrad(text: Strings.resetPassword)
                
                Spacer().frame(height: Height.smallHeight)
                VStack(spacing: Height.mediumHeight) {
                    tfIcon(iconSystemName: "envelope.fill", placeHolder: Strings.email, textInput: $viewModel.email)
                }

                Spacer()
                
                HStack(spacing: Height.xSmallHeight){
                    Spacer()
                    tvHeadline(text: Strings.reset, color: .blue500)
                    btnSystemIcon(iconSystemName: "arrow.right", color: .white) {
                        print("giriş yap tıklandı")
                    }
                }
                Spacer()
                HStack {
                    tvFootnote(text: Strings.alreadyAccount, color: .primary)
                    btnText(customView: tvFootnote(text: Strings.signIn, color: Color.orange700)) {
                        router.navigateBack()
                    }
                }
                Spacer()
            }
            .padding(.horizontal, Height.normalHeight)
        }.navigationBarBackButtonHidden()
    }
}

#Preview {
    ForgotPasswordUI()
}
