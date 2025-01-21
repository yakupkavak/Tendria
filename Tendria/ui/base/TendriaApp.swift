//
//  TendriaApp.swift
//  Tendria
//
//  Created by Yakup Kavak on 18.01.2025.
//

import SwiftUI

@main
struct TendriaApp: App {
    @ObservedObject var router = RouterSign()
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
                            SignUpUI()
                        case .forgotPassword:
                            ForgotPasswordUI()
                        }
                    }
            }.environmentObject(router)
        }
    }
}
