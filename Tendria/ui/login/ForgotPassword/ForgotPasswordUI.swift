import SwiftUI

struct ForgotPasswordUI: View {
    
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject private var router: RouterSign
    @StateObject var viewModel: ForgotPasswordViewModel
    
    init(authManager: AuthManager) {
        _viewModel = StateObject(wrappedValue: ForgotPasswordViewModel(authManager: authManager))
    }
    
    var body: some View {
        ZStack {
            VStack() {
                CustomWaveView(gradient: Gradient(colors: [Color.orange700, Color.red300]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(height: Height.mediumHeight)
                    .shadow(radius: Radius.normalRadius)
                Spacer()
            }
            .edgesIgnoringSafeArea(.top)
            
            VStack(spacing: Height.mediumHeight) {
                Spacer().frame(height: Height.mediumHeight)
                
                BigSizeBoldGrad(text: StringKey.reset_password)
                
                Spacer().frame(height: Height.smallHeight)
                VStack(spacing: Height.mediumHeight) {
                    tfIcon(iconSystemName: IconName.envelope, placeHolder: StringKey.email, textInput: $viewModel.email)
                }

                Spacer()
                
                HStack(spacing: Height.xSmallHeight){
                    Spacer()
                    tvHeadline(text: StringKey.reset, color: .blue500)
                    btnSystemIcon(iconSystemName: IconName.right_arrow, color: .white) {
                        viewModel.forgotPassword()
                    }
                }
                Spacer()
                HStack {
                    tvFootnote(text: StringKey.already_account, color: .primary)
                    btnText(customView: tvFootnote(text: StringKey.signIn, color: Color.orange700)) {
                        router.navigateBack()
                    }
                }
                Spacer()
            }
            .padding(.horizontal, Height.normalHeight)
        }.navigationBarBackButtonHidden()
            .alert(viewModel.alertType == .success ? getLocalizedString(StringKey.success) : getLocalizedString(StringKey.error), isPresented: $viewModel.showAllert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.alertType == .success ? viewModel.success : viewModel.error)
            }
    }
}

#Preview {
    let previewAuthManager = AuthManager()
    ForgotPasswordUI(authManager: previewAuthManager)
        .environmentObject(previewAuthManager)
}
