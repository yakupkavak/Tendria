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
    
    @StateObject private var routerTask = RouterTask()
    @StateObject private var routerUser = RouterUserInfo()
    
    private var userState = false
    @StateObject private var authManager = AuthManager.shared
    
    init() {
        FirebaseApp.configure()
    }

    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            if authManager.isSigned {
                BaseTabViewUI().environmentObject(routerTask).environmentObject(routerUser).onAppear {
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

