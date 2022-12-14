import UIKit

class SystemNotificationViewController: UIViewController {
   
   override func viewDidLoad() {
      super.viewDidLoad()
       NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationWillChangeStatusBarFrame, object: nil, queue: OperationQueue.main) { (noti) in
           print(noti.userInfo)
       }
      
   }   
}
