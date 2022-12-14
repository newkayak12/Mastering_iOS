import UIKit
import UserNotifications

class LocalNotificationViewController: UIViewController {
   var interval: TimeInterval = 1
   
   @IBOutlet weak var inputField: UITextField!
   
   @IBAction func schedule(_ sender: Any) {
       let content = UNMutableNotificationContent()
       content.title = "Hello"
       content.body = inputField.text ?? "Empty Body"
       content.badge = 123
       content.sound = UNNotificationSound.default()
       
       /**
        UNCalendarNotificationTrigger
        UNTimeIntervalNotificationTrigger
        UNLocationNotificationTrigger
        */
       let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
       let request = UNNotificationRequest(identifier: "test", content: content, trigger: trigger)
       UNUserNotificationCenter.current().add(request) { error in
           if let error = error {
               print(error)
           } else {
               print("Done")
           }
           
       }
       inputField.text = nil
       
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
       UIApplication.shared.applicationIconBadgeNumber = 0
      
   }
}


extension LocalNotificationViewController: UIPickerViewDataSource {
   func numberOfComponents(in pickerView: UIPickerView) -> Int {
      return 1
   }
   
   func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      return 60
   }
}

extension LocalNotificationViewController: UIPickerViewDelegate {
   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      return "\(row + 1)"
   }
   
   func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      interval = TimeInterval(row + 1)
   }
}




















