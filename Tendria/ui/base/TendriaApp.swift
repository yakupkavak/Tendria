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
    init() {
        FirebaseApp.configure()
    }
    @StateObject var authManager = AuthManager()
    @StateObject var router = RouterSign()
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                Group{
                    if authManager.checkUserSession() {
                        BaseTabViewUI()
                    } else {
                        SignInUI(authManager: authManager)
                    }
                }.navigationDestination(for: RouterSign.Destination.self) { destination in
                    switch destination {
                    case .signIn:
                        SignInUI(authManager: authManager)
                    case .signUp:
                        SignUpUI(authManager: authManager)
                    case .forgotPassword:
                        ForgotPasswordUI(authManager: authManager)
                    case .mainScreen:
                        BaseTabViewUI()
                    
                    }
                }
            }
            .environmentObject(router)
            .environmentObject(authManager).onAppear {
                UIApplication.shared.addTapGestureRecognizer()
            }
        }
    }
}

