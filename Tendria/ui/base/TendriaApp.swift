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
    
    private var userState = false
    @StateObject private var authManager = AuthManager.shared
    
    init() {
        FirebaseApp.configure()
    }

    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            if authManager.isSigned {
                BaseTabViewUI().onAppear {
                    UIApplication.shared.addTapGestureRecognizer()
                }
            } else {
                SignContainerUI().onAppear {
                    UIApplication.shared.addTapGestureRecognizer()
                }
            }
        }
    }
}

