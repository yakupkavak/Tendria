//
//  SignContainerUI.swift
//  Tendria
//
//  Created by Yakup Kavak on 18.02.2025.
//

import SwiftUI

struct SignContainerUI: View {
    
    @StateObject private var router = RouterUserSign()
    
    var body: some View {
        NavigationStack(path: $router.navPath){
            SignInUI().environmentObject(router)
                .navigationDestination(for: RouterUserSign.Destination.self) { destination in
                    switch destination {
                    case .signIn:
                        SignInUI().environmentObject(router)
                    case .signUp:
                        SignUpUI().environmentObject(router)
                    case .forgotPassword:
                        ForgotPasswordUI().environmentObject(router)
                    }
                }
        }.onAppear {
            NotificationCenter.default.addObserver(forName: NSNotification.Name("NavigateToScreen"), object: nil, queue: .main) { notification in
                if let screen = notification.object as? String {
                    DispatchQueue.main.async {
                        if screen == "profile" {
                            router.navPath.append(RouterUserSign.Destination.forgotPassword)
                        } else if screen == "signUp" {
                            router.navPath.append(RouterUserSign.Destination.signUp)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SignContainerUI()
}
