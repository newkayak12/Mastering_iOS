import UIKit
import UserNotifications

class AttachmentsViewController: UIViewController {
   
   @IBAction func addImageAttachment(_ sender: Any) {
      let content = UNMutableNotificationContent()
      content.title = "Hello"
      content.body = "Image Attachment"
      content.sound = UNNotificationSound.default()
       guard let url = Bundle.main.url(forResource: "hello", withExtension: "png") else {return}
       var options = [UNNotificationAttachmentOptionsThumbnailHiddenKey:true]
       guard let imageAttachment = try?
                UNNotificationAttachment(identifier: "hello-image", url: url, options: options) else {return}
       
       guard let thumbUrl = Bundle.main.url(forResource: "logo", withExtension: "png") else {return}
       options = [UNNotificationAttachmentOptionsThumbnailHiddenKey:false]
       guard let thumbnailAttachment = try?
                UNNotificationAttachment(identifier: "thumbnail-image", url: thumbUrl, options: options) else{return}
       content.attachments = [imageAttachment, thumbnailAttachment]
      
      
      let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
      let request = UNNotificationRequest(identifier: "Image Attachment", content: content, trigger: trigger)
      UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
   }
   
   @IBAction func addAudioAttachment(_ sender: Any) {
      let content = UNMutableNotificationContent()
      content.title = "Hello"
      content.body = "Audio Attachment"
      content.sound = UNNotificationSound.default()
       
       guard let url = Bundle.main.url(forResource: "bell", withExtension: "aif") else {return}
       guard let audioAttachment = try? UNNotificationAttachment(identifier: "audio", url: url) else {return}
       
       content.attachments = [audioAttachment]
      
      
      
      let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
      let request = UNNotificationRequest(identifier: "Audio Attachment", content: content, trigger: trigger)
      UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
   }
   
   @IBAction func addVideoAttachment(_ sender: Any) {
      let content = UNMutableNotificationContent()
      content.title = "Hello"
      content.body = "Video Attachment"
      content.sound = UNNotificationSound.default()

       guard let url = Bundle.main.url(forResource: "video", withExtension: "mp4") else {return}
       guard let videoAttachment = try? UNNotificationAttachment(identifier: "video", url: url) else {return}
       content.attachments = [videoAttachment]
      
      
      let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
      let request = UNNotificationRequest(identifier: "Video Attachment", content: content, trigger: trigger)      
      UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      
   }
}


