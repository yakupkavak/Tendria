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
        let authManager = AuthManager()
        _authManager = StateObject(wrappedValue: authManager)
    }
    
    @StateObject var authManager : AuthManager
    @StateObject var router = RouterSign()
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                SignInUI()
                    .navigationDestination(for: RouterSign.Destination.self) { destination in
                        switch destination {
                        case .signIn:
                            SignInUI()
                        case .signUp:
                            SignUpUI(authManager: authManager)
                        case .forgotPassword:
                            ForgotPasswordUI()
                        case .feed:
                            FeedUI()
                        }
                    
                    }
            }.environmentObject(router)
                .environmentObject(authManager)
        }
    }
}

