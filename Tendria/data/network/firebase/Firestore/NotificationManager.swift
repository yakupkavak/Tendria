//
//  NotificationManager.swift
//  Tendria
//
//  Created by Yakup Kavak on 28.02.2025.
//

import Foundation
import UserNotifications

@MainActor
class NotificationManager: ObservableObject{
    @Published private(set) var hasPermission = false
    
    init() {
        print("notification yaratıldı")
        Task{
            await getAuthStatus()
        }
    }
    
    func request() async{
        do { //kullanıcıdan izin istiyoruz
            try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
             await getAuthStatus()
        } catch{
            print(error)
        }
    }
    
    func getAuthStatus() async {
        let status = await UNUserNotificationCenter.current().notificationSettings()
        switch status.authorizationStatus {
        case .authorized, .ephemeral, .provisional:
            hasPermission = true
        default:
            hasPermission = false
        }
    }
}
