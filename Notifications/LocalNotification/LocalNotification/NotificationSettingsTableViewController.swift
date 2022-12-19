import UIKit
import UserNotifications

class NotificationSettingsTableViewController: UITableViewController {
   
   @IBOutlet weak var authorizationStatusLabel: UILabel!
   @IBOutlet weak var alertStyleLabel: UILabel!
   @IBOutlet weak var showPreviewsLabel: UILabel!
   @IBOutlet weak var alertLabel: UILabel!
   @IBOutlet weak var badgeLabel: UILabel!
   @IBOutlet weak var soundLabel: UILabel!
   @IBOutlet weak var notificationCenterLabel: UILabel!
   @IBOutlet weak var lockScreenLabel: UILabel!
   
   func update(from settings: UNNotificationSettings) {
       switch settings.authorizationStatus {
       case .notDetermined:
           authorizationStatusLabel.text = "Not Determined"
       case .authorized:
           authorizationStatusLabel.text = "Authorized"
       case .denied:
           authorizationStatusLabel.text = "Denied"
       default:
           break;
       }
       
       switch settings.soundSetting {
           case .disabled:
               soundLabel.text = "Disalbed"
           case .enabled:
               soundLabel.text = "Enabled"
           case .notSupported:
               soundLabel.text = "Not Supported"
           default:
               break;
       }
       
       badgeLabel.text = settings.badgeSetting.stringValue
       lockScreenLabel.text = settings.lockScreenSetting.stringValue
       notificationCenterLabel.text = settings.notificationCenterSetting.stringValue
       alertLabel.text = settings.alertSetting.stringValue
       
       switch settings.alertStyle {
            case .banner:
                alertStyleLabel.text = "Banner"
            case .alert:
                alertStyleLabel.text = "Alert"
            case .none:
                alertStyleLabel.text = "None"
            default:
                break;
       }
       
       if #available(iOS 11.0, *) {
           switch settings.showPreviewsSetting {
           case .always:
               showPreviewsLabel.text = "Always"
           case .whenAuthenticated:
               showPreviewsLabel.text = "when Authenticated"
           case .never:
               showPreviewsLabel.text = "never"
           default:
               break;
           }
       }
       
   }
   
   @objc func refresh() {
       UNUserNotificationCenter.current().getNotificationSettings { (settings) in
           DispatchQueue.main.async {
               self.update(from: settings)
           }
       }
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      refresh()
      
      NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
       
       UNUserNotificationCenter.current().getNotificationSettings { settins in
           guard settins.authorizationStatus == .authorized else { return }
           let content = UNMutableNotificationContent()
           content.title = "Hello"
           content.body = "Have a nice day:)"
           content.sound = UNNotificationSound.default()
           
           let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
           let request = UNNotificationRequest(identifier: "HelloNoti", content: content, trigger: trigger)
           
           UNUserNotificationCenter.current().add(request) { (error) in print(error)}
       }
      
   }
}

extension UNNotificationSetting {
   var stringValue: String {
      switch self {
      case .notSupported:
         return "Not Supported"
      case .enabled:
         return "Enabled"
      case .disabled:
         return "Disabled"
      }
   }
}


















