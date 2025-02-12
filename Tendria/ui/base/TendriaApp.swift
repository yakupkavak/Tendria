//
//  TendriaApp.swift
//  Tendria
//
//  Created by Yakup Kavak on 18.01.2025.
//

import SwiftUI
import FirebaseCore

@main
struct TendriaApp: App {
    
    @StateObject var router = RouterSign()
    @ObservedObject private var authManager: AuthManager
    
    init() {
        FirebaseApp.configure()
        self._authManager = ObservedObject(wrappedValue: AuthManager.shared)
    }

    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                Group{
                    if authManager.isSigned {
                        BaseTabViewUI()
                    } else {
                        SignInUI()
                    }
                }.navigationDestination(for: RouterSign.Destination.self) { destination in
                    switch destination {
                    case .signIn:
                        SignInUI()
                    case .signUp:
                        SignUpUI()
                    case .forgotPassword:
                        ForgotPasswordUI()
                    case .mainScreen:
                        BaseTabViewUI()
                    }
                }
            }
            .environmentObject(router)
            .onAppear {
                UIApplication.shared.addTapGestureRecognizer()
            }
        }
    }
}

