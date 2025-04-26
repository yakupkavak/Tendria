//
//  View.swift
//  Tendria
//
//  Created by Yakup Kavak on 1.02.2025.
//

import SwiftUI
extension UIApplication {
    func addTapGestureRecognizer() {
            // Aktif windowScene'e ve onun içindeki ilk window'a erişiyoruz
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return } // Eğer erişim olmazsa çık

            // Bir UITapGestureRecognizer oluşturuyoruz. Hedef: window. Aksiyon: klavyeyi kapat
            let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))

            // Diğer dokunma türleriyle çakışmaması için false yapılıyor
            tapGesture.requiresExclusiveTouchType = false
            
            // Diğer dokunmaların çalışmasını engelleme. Örn: ScrollView scroll edebilsin
            tapGesture.cancelsTouchesInView = false
            
            // Gesture’ın delegate'ini UIApplication’a veriyoruz (bu sayede kontrol bizde)
            tapGesture.delegate = self
            
            // Gesture’ı window’a ekliyoruz
            window.addGestureRecognizer(tapGesture)
        }
}

extension UIApplication: @retroactive UIGestureRecognizerDelegate {
    // Bu fonksiyon, birden fazla gesture’ın aynı anda tanınmasını kontrol eder
        public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            // Eğer diğer gesture bir LongPress değilse, ikisi aynı anda çalışabilir
            return !otherGestureRecognizer.isKind(of: UILongPressGestureRecognizer.self)
        }
}
extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}
extension Image{
    func findTrueSize(uiImage: UIImage,maxHeight: CGFloat, maxWidth: CGFloat) -> some View{
        if(isWidthHigher(uiImage: uiImage)){
            self.resizable().scaledToFit().frame(width: maxWidth).clipShape(RoundedRectangle(cornerRadius: Radius.mediumRadius))
        }else{
            self.resizable().scaledToFit().frame(height: maxHeight).clipShape(RoundedRectangle(cornerRadius: Radius.mediumRadius))
        }
    }

    private func isWidthHigher(uiImage: UIImage) -> Bool {
        let width = uiImage.size.width
        let height = uiImage.size.height

        if(width >= height){
            return true
        }else {
            return false
        }
    }
}
extension View{
    func paddingHorizontal(value: CGFloat = 8) -> some View{
        self.padding([.leading,.trailing], value)
    }
    func DoubleSpacer() -> some View{
        Group{
            Spacer()
            Spacer()
        }
    }
    func showNewRelation(
        isPresent: Binding<Bool>,
        onSuccess: @escaping () -> Void,
        messageText: String
    ) -> some View{
        
        self.overlay {
            if isPresent.wrappedValue {
                ZStack {
                    // Alert içeriği
                    BaseLottieAlertUI(uiLottieSource: LottieSet.BEAR_CAT_JSON,backgroundFirst: LottieSet.FIREWORK_JSON,backgroundSecond: LottieSet.CONFETTI_JSON, title: StringKey.new_relation_title, message: messageText, onSuccessText: StringKey.continue_text) {
                        onSuccess()
                    }
                }
                .transition(.opacity)
                .animation(.easeInOut, value: isPresent.wrappedValue)
            }
        }
    }
    
    func showLoading(
        isPresent: Binding<Bool>
    ) -> some View{
        self.overlay {
            if isPresent.wrappedValue {
                ZStack {
                    // Alert içeriği
                    LoadingAlertUI()
                }
                .transition(.opacity)
                .animation(.easeInOut, value: isPresent.wrappedValue)
            }
        }
    }
    
    func showRequestNotification(
        isPresent: Binding<Bool>,
        onSuccess: @escaping () -> Void,
        onDenied: @escaping () -> Void
        
    ) -> some View{
        self.overlay {
            if isPresent.wrappedValue {
                ZStack {
                    // Alert içeriği
                    BaseImageAlertUI(
                        onSuccess: {
                            onSuccess()
                        },
                        onDenied: {
                            onDenied()
                        }
                    )
                }
                .transition(.opacity)
                .animation(.easeInOut, value: isPresent.wrappedValue)
            }
        }
    }
    
    func keyboardAdaptive(canUpdate: Binding<Bool>) -> some View {
        ModifiedContent(content: self, modifier: KeyboardAdaptive(canUpdate: canUpdate))
    }
    
    func stackPosition(position: Int, zeroIndexWidth: CGFloat) -> some View {
        var offset = CGFloat(0)
        switch position {
        case 0: offset = 0
        case 1: offset = -zeroIndexWidth * 0.5
        case 2: offset = zeroIndexWidth * 0.5
        default: break
        }
        return self.offset(x: offset)
    }
}
