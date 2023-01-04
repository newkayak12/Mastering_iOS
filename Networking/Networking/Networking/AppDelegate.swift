
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
   var window: UIWindow?

   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

      return true
   }
    
    //백그라운드 작업이 앱이 꺼진 상태에서 끝나면 실행
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        NSLog(">> %@ %@", self, #function)
        
        
        _ = BackgroundDownloadManager.shared.session
        BackgroundDownloadManager.shared.completionHandler = completionHandler
    }

}

