import SwiftUI
import AuthenticationServices

struct SignUpUI: View {
    
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var router: RouterSign
    @StateObject var viewModel: SignUpViewModel
    
    init(authManager: AuthManager) {
        _viewModel = StateObject(wrappedValue: SignUpViewModel(authManager: authManager))
    }
    
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
                Spacer().frame(height: Height.xLargeHeight)
                
                BigSizeBoldGrad(text: Strings.createAccount)

                VStack(spacing: Height.mediumHeight) {
                    tfIcon(iconSystemName: "envelope.fill", placeHolder: Strings.email, textInput: $viewModel.email)
                    tfIcon(iconSystemName: "lock.fill", placeHolder: Strings.password, textInput: $viewModel.password)
                    tfIcon(iconSystemName: "person.fill", placeHolder: Strings.full_name, textInput: $viewModel.fullName)
                    tfIcon(iconSystemName: "person.fill", placeHolder: Strings.username, textInput: $viewModel.userName)
                }
                
                HStack(spacing: Height.xSmallHeight){
                    Spacer()
                    tvHeadline(text: Strings.create, color: .blue500)
                    btnSystemIcon(iconSystemName: "arrow.right", color: .white) {
                        viewModel.signUpEmail()
                    }
                }
                
                Spacer()
                
                HStack {
                    tvFootnote(text: Strings.alreadyAccount, color: .primary)
                    btnText(customView: tvFootnote(text: Strings.signIn, color: Color.orange700)) {
                        router.navigateBack()
                    }
                }
                
                HStack(spacing: Height.xSmallHeight){
                    /*
                    SignInWithAppleButton { request in
                        AppleSignInManager.shared.requestAppleAuthorization(request)
                    } onCompletion: { result in
                        handleAppleID(result)
                    }
                     */
                    btnSignIcon(iconName: "appleIcon") {
                        Task{
                            viewModel.signInWithApple() {
                                router.navigate(to: .feed)
                            }
                        }
                    }
                    btnSignIcon(iconName: "googleIcon") {
                        Task{
                            viewModel.signInWithGoogle {
                                router.navigate(to: .feed)
                            }
                        }
                    }
                    
                }
            }
            .padding(.horizontal, Height.normalHeight)
        }.navigationBarBackButtonHidden()
            .onChange(of: viewModel.success) {
                if viewModel.success {
                    print("✅ Kayıt başarılı! Ana ekrana yönlendiriliyor...")
                    router.navigate(to: .feed) // Başarılıysa yönlendirme yap
                }
            }
            .onChange(of: viewModel.error) {
                if !viewModel.error.isEmpty {
                    print("❌ Hata oluştu: \(viewModel.error)")
                }
            }
    }
    
}

#Preview {
    let previewAuthManager = AuthManager() // Geçici bir AuthManager oluştur
    return SignUpUI(authManager: previewAuthManager)
        .environmentObject(previewAuthManager) // Preview için environmentObject ver
}
