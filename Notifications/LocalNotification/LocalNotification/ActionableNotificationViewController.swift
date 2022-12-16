import UIKit
import UserNotifications

class ActionableNotificationViewController: UIViewController {
   @IBOutlet weak var imageView: UIImageView!
   
   @IBAction func schedule(_ sender: Any) {
      let content = UNMutableNotificationContent()
      content.title = "Hello"
      content.body = "KxCoding just shared a photo."
      content.sound = UNNotificationSound.default()
      
       
       content.categoryIdentifier = CategoryIdentifier.imagePosting
      guard let url = Bundle.main.url(forResource: "hello", withExtension: "png") else {
         return
      }
      
      guard let imageAttachment = try? UNNotificationAttachment(identifier: "logo-image", url: url, options: nil) else {
         return
      }
      content.attachments = [imageAttachment]
      
      let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
      let request = UNNotificationRequest(identifier: "Image Attachment", content: content, trigger: trigger)
      UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
   }
   
    @objc func updateSelection(){
        switch UserDefaults.standard.string(forKey: "usersel") {
        case .some(ActionIdentifier.like):
            imageView.image = UIImage(named: "thumb-up")
        case .some(ActionIdentifier.disliks):
            imageView.image = UIImage(named: "thumb-down")
        default:
            imageView.image = UIImage(named: "question")
        }
    }
   override func viewDidLoad() {
      super.viewDidLoad()
       NotificationCenter.default.addObserver(self, selector: #selector(updateSelection), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
   }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateSelection()
    }
}
















