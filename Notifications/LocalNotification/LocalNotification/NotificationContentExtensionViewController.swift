import UIKit
import UserNotifications

class NotificationContentExtensionViewController: UIViewController {
   
   
   @IBAction func schedule(_ sender: Any) {
      let content = UNMutableNotificationContent()
      content.title = "Hello"
      content.body = "Have a nice day :)"
      content.sound = UNNotificationSound.default()
      
      guard let url = Bundle.main.url(forResource: "hello", withExtension: "png") else {
         return
      }
      
      guard let imageAttachment = try? UNNotificationAttachment(identifier: "logo-image", url: url, options: nil) else {
         return
      }
      
      content.attachments = [imageAttachment]
      
      let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
      
      let request = UNNotificationRequest(identifier: "Hello", content: content, trigger: trigger)
      
      UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // Do any additional setup after loading the view.
   }
}
