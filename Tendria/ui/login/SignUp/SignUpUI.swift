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
                
                BigSizeBoldGrad(text: StringKey.create_account)

                VStack(spacing: Height.mediumHeight) {
                    tfIcon(iconSystemName: IconName.envelope, placeHolder: StringKey.email, textInput: $viewModel.email)
                    tfIcon(iconSystemName: IconName.lock, placeHolder: StringKey.password, textInput: $viewModel.password)
                    tfIcon(iconSystemName: IconName.person, placeHolder: StringKey.full_name, textInput: $viewModel.fullName)
                    tfIcon(iconSystemName: "person.fill", placeHolder: StringKey.username, textInput: $viewModel.userName)
                }
                
                HStack(spacing: Height.xSmallHeight){
                    Spacer()
                    tvHeadline(text: StringKey.create, color: .blue500)
                    btnSystemIcon(iconSystemName: IconName.right_arrow, color: .white) {
                        viewModel.signUpEmail()
                    }
                }
                                
                HStack {
                    tvFootnote(text: StringKey.already_account, color: .primary)
                    btnText(customView: tvFootnote(text: StringKey.signIn, color: Color.orange700)) {
                        router.navigateBack()
                    }
                }
                
                HStack(spacing: Height.xSmallHeight){
                    btnSignIcon(iconName: IconName.appleIcon) {
                        Task{
                            viewModel.signInWithApple()
                        }
                    }
                    btnSignIcon(iconName: IconName.googleIcon) {
                        Task{
                            viewModel.signInWithGoogle()
                        }
                    }
                    
                }
            }
            .padding(.horizontal, Height.normalHeight)
        }.navigationBarBackButtonHidden()
            .onChange(of: viewModel.success) {
                if viewModel.success {
                    print("✅ Kayıt başarılı! Ana ekrana yönlendiriliyor...")
                    router.navigate(to: .feed)
                }
            }
            .onChange(of: viewModel.error) {
                if !viewModel.error.isEmpty {
                    print("❌ Hata oluştu: \(viewModel.error)")
                }
            }.alert(StringKey.error, isPresented: $viewModel.showAllert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.error)
            }

    }
    
}

#Preview {
    let previewAuthManager = AuthManager() // Geçici bir AuthManager oluştur
    return SignUpUI(authManager: previewAuthManager)
        .environmentObject(previewAuthManager) // Preview için environmentObject ver
}
