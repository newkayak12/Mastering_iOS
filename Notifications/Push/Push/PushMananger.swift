//
//  pushMananger.swift
//  Push
//
//  Created by Sang Hyeon kim on 2022/12/16.
//

import UIKit
import Foundation
import UserNotifications


class PushManager: NSObject {
    static let shared = PushManager()
    
    let hub: SBNotificationHub
    private override init() {
        hub = SBNotificationHub(connectionString: hubConnectionString, notificationHubPath: hubName)
        super.init()
    }
    
    func setupCategory() {
        let confirmAction = UNNotificationAction(identifier: "ACTION_CONFIRM", title: "Confirm Request", options: [])
        let deleteAction = UNNotificationAction(identifier: "ACTION_DELETE", title: "Delete Request", options: [])
        
        let friendRequestCateogry = UNNotificationCategory(identifier: "CATEGORY_FRIEND_REQUEST", actions: [confirmAction, deleteAction], intentIdentifiers: [], options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([friendRequestCateogry])
    }
    
    
    func setUp(){
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.sound, .alert, .badge]) { granted, error in
            if granted && error == nil {
                self.setupCategory()
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }
    
    func registerDeviceToken(token: Data){
        hub.registerNative(withDeviceToken: token) {(error) in
            if let error = error {
                print("reg error :\(error.localizedDescription)")
            } else {
                print("reg ok")
            }
        }
    }
}

extension PushManager: UNUserNotificationCenterDelegate {
    /**
     silentPush에서 content-available  이외 다른 키가 있으면 여기가 실행된다.
     */
    //foreGround에서
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if let aps = notification.request.content.userInfo["aps"] as? [AnyHashable: Any], let _ = aps["content-available"] {
            completionHandler([])
            return
        }
        
        print("#2 \(#function)", notification.request.content.userInfo, separator: "\n")
        print(notification.request.content.userInfo)
        
        if let data = notification.request.content.userInfo["data"] as? String {
            UserDefaults.standard.set(data, forKey: "data")
            UserDefaults.standard.synchronize()
            NotificationCenter.default.post(name: NSNotification.Name.DataDidReceive, object: nil)
        }
        
        
        completionHandler([.badge])
    }
    //background에서
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("#3 \(#function)", response.notification.request.content.userInfo, separator: "\n")
        
        if let data = response.notification.request.content.userInfo["data"] as? String {
            UserDefaults.standard.set(data, forKey: "data")
            UserDefaults.standard.synchronize()
            NotificationCenter.default.post(name: NSNotification.Name.DataDidReceive, object: nil)
        }
        
        switch response.actionIdentifier {
        case "ACTION_CONFIRM":
            print("confirm")
        case "ACTION_DELTE":
            print("delete")
        default:
            print("default")
        }
        
        completionHandler()
    }
}
