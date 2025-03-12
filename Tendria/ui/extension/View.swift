//
//  View.swift
//  Tendria
//
//  Created by Yakup Kavak on 1.02.2025.
//

import SwiftUI
extension UIApplication {
    func addTapGestureRecognizer() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return } // ✅ iOS 15+ için `UIWindowScene` kullanımı
        
        let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapGesture.requiresExclusiveTouchType = false
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        window.addGestureRecognizer(tapGesture)
    }
}

extension UIApplication: @retroactive UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return !otherGestureRecognizer.isKind(of: UILongPressGestureRecognizer.self)
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
}

