import UIKit
import UserNotifications

class CustomSoundViewController: UIViewController {
   @IBAction func useCustomSound(_ sender: Any) {
      let content = UNMutableNotificationContent()
      content.title = "Hello"
      content.body = "Custom Sound"
//      content.sound = UNNotificationSound.default()
      content.sound = UNNotificationSound(named: "bell.aif")
      
      let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
      
      let request = UNNotificationRequest(identifier: "CustomSound", content: content, trigger: trigger)
      
      UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
   }
}

























