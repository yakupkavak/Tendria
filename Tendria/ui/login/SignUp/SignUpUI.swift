import SwiftUI

struct SignUpUI: View {
    
    @EnvironmentObject var router: RouterSign
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var email: String = ""
    var body: some View {
        ZStack {
            VStack() {
                CustomWaveView(gradient: Gradient(colors: [Color.orange700, Color.red300]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(height: Height.mediumHeight)
                    .shadow(radius: Radius.normalRadius)
                Spacer()
            }
            .edgesIgnoringSafeArea(.top)//ekranın çentiklerini vs göz artı edip en yukarı çık
            
            VStack(spacing: Height.xMediumHeight) {
                Spacer().frame(height: Height.largeHeight)
                
                BigSizeBoldGrad(text: Strings.createAccount)

                VStack(spacing: Height.mediumHeight) {
                    tfIcon(iconSystemName: "person.fill", placeHolder: Strings.username, textInput: $username)
                    tfIcon(iconSystemName: "lock.fill", placeHolder: Strings.password, textInput: $password)
                    tfIcon(iconSystemName: "envelope.fill", placeHolder: Strings.email, textInput: $email)
                }

                Spacer()
                
                HStack(spacing: Height.xSmallHeight){
                    Spacer()
                    tvHeadline(text: Strings.create, color: .blue500)
                    btnIcon(iconSystemName: "arrow.right", color: .white) {
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
    SignUpUI()
}
