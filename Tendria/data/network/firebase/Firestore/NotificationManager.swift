//
//  NotificationManager.swift
//  Tendria
//
//  Created by Yakup Kavak on 28.02.2025.
//

import Foundation
import UserNotifications
import UIKit
import SwiftUI

@MainActor
class NotificationManager: ObservableObject{
    @Published private(set) var hasPermission = false
    
    var permissionBinding: Binding<Bool> {
        Binding {
            self.hasPermission
        } set: { _ in
            
        }
    }
    
    init() {
        Task{
            await getAuthStatus()
        }
    }
    
    func request(requestType: NotificationRequestType) async{
        do { //kullanıcıdan izin istiyoruz
            if requestType == .navigateSettings {
                let status = await UNUserNotificationCenter.current().notificationSettings()
                if status.authorizationStatus == .denied {
                    DispatchQueue.main.async {
                        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(settingsURL)
                        }
                    }
                    return
                }
            }
            else if requestType == .requestNotification{
                try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
            }
            
            await getAuthStatus()
        } catch{
            print(error)
        }
    }
    
    public enum NotificationRequestType {
        case navigateSettings
        case requestNotification
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
