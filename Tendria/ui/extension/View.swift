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
    
    func customImageAlert(
        isPresent: Binding<Bool>,
        onSuccess: @escaping () -> Void,
        onDenied: @escaping () -> Void
    ) -> some View{
        fullScreenCover(isPresented: isPresent) {
            BaseImageAlertUI(isPresented: isPresent) {
                onSuccess()
            } onDenied: {
                onDenied()
            }
        }.presentationBackground(.clear)
    }
}

