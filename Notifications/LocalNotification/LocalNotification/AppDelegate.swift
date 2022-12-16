import UIKit
import UserNotifications


struct ActionIdentifier {
    static let like = "ACTION_LIKE"
    static let disliks = "ACTION_DISLIKE"
    static let unfollow = "ACTION_UNFOLLOW"
    static let setting = "ACTION_SETTING"
    
    private init() {}
}

struct CategoryIdentifier {
    static let imagePosting = "CATEGORY_IMAGE_POSTING"
    private init() {}
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
   var window: UIWindow?
   
    
    func setUpCategory(){
        let likeAction = UNNotificationAction(identifier: ActionIdentifier.like, title: "Like", options: [])
        let dislikeAction = UNNotificationAction(identifier: ActionIdentifier.disliks, title: "Dislike")
        let unFollow = UNNotificationAction(identifier: ActionIdentifier.unfollow, title: "Unfollow", options: [.authenticationRequired, .destructive])
        let settingAction = UNNotificationAction(identifier: ActionIdentifier.setting, title: "Setting", options: [.foreground])
        
        
        var options = UNNotificationCategoryOptions.customDismissAction
        
        if #available(iOS 11.0, *){
            options.insert(.hiddenPreviewsShowTitle)
        }
        
        let imagePostingCategory = UNNotificationCategory(identifier: CategoryIdentifier.imagePosting, actions: [likeAction, dislikeAction, unFollow, settingAction], intentIdentifiers: [], options: options)
        UNUserNotificationCenter.current().setNotificationCategories([imagePostingCategory])
       
    }
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
   
      UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert, .sound]) { granted, error in
          if granted {
              self.setUpCategory()
              UNUserNotificationCenter.current().delegate = self
          }
          print("granted \(granted)")
      }
      return true
   }

}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let content = notification.request.content
        let trigger = notification.request.trigger
        
        completionHandler([UNNotificationPresentationOptions.banner, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) { ///action시 여기 호출
        let content = response.notification.request.content
        let trigger = response.notification.request.trigger
        
        switch response.actionIdentifier {
            case ActionIdentifier.like:
                    print("Like")
            case ActionIdentifier.disliks:
                    print("Dislike")
            case UNNotificationDefaultActionIdentifier:
                print("custom dismiss")
            case UNNotificationDefaultActionIdentifier:
                print("launch from noti")
            default:
                print("default")
        }
        UserDefaults.standard.set(response.actionIdentifier, forKey: "usersel")
        UserDefaults.standard.synchronize()
        
        
        completionHandler()
    }
}

























