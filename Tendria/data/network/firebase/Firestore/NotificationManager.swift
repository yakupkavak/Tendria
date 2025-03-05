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
    static let shared = NotificationManager()

    private init(){
        Task{
            await getAuthStatus()
        }
    }
    @Published private(set) var hasPermission = false

    var permissionBinding: Binding<Bool> {
        Binding {
            self.hasPermission
        } set: { _ in
            
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
        case .notDetermined: // Kullanıcı henüz bildirim izniyle ilgili karar vermediyse
            hasPermission = true
        default:
            hasPermission = false
        }
    }
    
    func handleNotification(customData: [AnyHashable : Any]){
        if let screen = customData["screen"] as? String {
            print("📩 Gelen Bildirimle Yönlendirme: \(screen)")
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: NSNotification.Name("NavigateToScreen"), object: screen)
            }
        } else {
            print("⚠️ Bildirimde yönlendirme için 'screen' key'i bulunamadı.")
        }
    }
}
