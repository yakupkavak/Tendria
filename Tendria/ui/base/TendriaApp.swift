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

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        application.registerForRemoteNotifications() //for recieve notification
        implementAppCheck()
        implementCloudMessage()
        return true
    }
    
    func implementCloudMessage(){
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        Messaging.messaging().delegate = self
    }
    
    func implementAppCheck(){
        UserDefaults.standard.set(true, forKey: "FirebaseAppCheckDebugMode")
        //let providerFactory = AppCheckProviderFactoryClass()
        AppCheck.setAppCheckProviderFactory(AppCheckDebugProviderFactory())
        FirebaseApp.configure()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        if let fcm = Messaging.messaging().fcmToken {
            print("fcm", fcm)
        }
    }
}

@main
struct TendriaApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
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

