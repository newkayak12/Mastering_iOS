//
//  AppDelegate.swift
//  remotePush
//
//  Created by Sang Hyeon kim on 2022/12/16.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        if let payload = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] as? [AnyHashable: Any] {
            
        }
        PushManager.shared.setUp()
        return true
    }
}

extension AppDelegate{
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        PushManager.shared.registerDeviceToken(token: deviceToken)
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
    //silent푸시는 여기서
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        print("#1\(#function)", userInfo, separator: "\n")
        
        if let data = userInfo["data"] as? String {
            UserDefaults.standard.set(data, forKey: "data")
            UserDefaults.standard.synchronize()
        }
//        completionHandler(UIBackgroundFetchResult.noData)
        
        if application.applicationState == .active {
            NotificationCenter.default.post(name: NSNotification.Name.DataDidReceive, object: nil)
        }
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
}

