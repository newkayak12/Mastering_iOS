
import UIKit
let thresholdKey = "thresholdKey"
let initialLaunchKey = "initialLaunchKey"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

   var window: UIWindow?


   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
       
       if !UserDefaults.standard.bool(forKey: initialLaunchKey) {
           let defaultSettings = [thresholdKey:123] as [String:Any]
           UserDefaults.standard.register(defaults: defaultSettings)
           UserDefaults.standard.set(true, forKey: initialLaunchKey)
           
           print("InitialLaunch")
       }
      
      
      return true
   }
}

