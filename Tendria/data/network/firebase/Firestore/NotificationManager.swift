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
    @Published private(set) var requestPermission = false
    
    var requestPermissionBinding: Binding<Bool> {
        Binding {
            self.requestPermission
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
        FirestorageManager.shared.configureFcmToken()
    }
    
    func getAuthStatus() async {
        let status = await UNUserNotificationCenter.current().notificationSettings()
        switch status.authorizationStatus {
        case .authorized, .ephemeral, .provisional:
            requestPermission = false
        case .notDetermined: // Kullanıcı henüz bildirim izniyle ilgili karar vermediyse
            requestPermission = true
        case .denied:
            requestPermission = false
        default:
            requestPermission = true
        }
    }
    
    func handleNotification(customData: [AnyHashable : Any]){
        do {
            //her gelen veri jsona çevrildi öncelikle
            let jsonData = try JSONSerialization.data(withJSONObject: customData)
            //sırasıyla hangi veri tipi olduğunu bulmaya çalışalım
            guard let keyData = try JSONSerialization.jsonObject(with: jsonData, options: .topLevelDictionaryAssumed) as? [String: Any] else{
                print("dönüştürülemedi key dataya")
                return
            }
            guard let alertType = keyData[NotificationKey.TYPE] as? String else {
                print("check data yapılamadı")
                return
            }
            if alertType == NotificationKey.NEW_RELATION {
                let notificationJsonData = try JSONDecoder().decode(NotificationJSONData.self,from: jsonData)
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name("NavigateToScreen"), object: screen)
                }
            }
            
            
        }catch {
            print(error.localizedDescription)
        }
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
