//
//  TendriaApp.swift
//  Tendria
//
//  Created by Yakup Kavak on 18.01.2025.
//

import SwiftUI
import FirebaseCore
import FirebaseAppCheck
import FirebaseMessaging

@main
struct TendriaApp: App {
    
    @UIApplicationDelegateAdaptor(CustomAppDelegate.self) var delegate
    
    @StateObject private var routerTask = RouterTask()
    @StateObject private var routerUser = RouterUserInfo()
    @StateObject private var authManager = AuthManager.shared

    private var userState = false
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

