import UIKit
import UserNotifications

class PendingNotificationsTableViewController: UITableViewController {
   var pendingNotifications = [UNNotificationRequest]()
   
   func refresh() {
       
       print(#function)
      pendingNotifications.removeAll()
      
       UNUserNotificationCenter.current().getPendingNotificationRequests { [weak self] (requests) in
           print("request \(requests.count)")


           self?.pendingNotifications = requests
           DispatchQueue.main.async {
               self?.tableView.reloadData()
           }
       }
      
   }
   
   @objc func scheduleNotifications() {
      for interval in 1...10 {
         let content = UNMutableNotificationContent()
         content.title = "Notification Title #\(interval)"
         content.body = "Notification Body #\(interval)"
         
         let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(interval), repeats: false)
         let request = UNNotificationRequest(identifier: "nid22\(interval)", content: content, trigger: trigger)
         print("NOTIFICATION \(interval)")
         UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
          
      }
      
      refresh()
   }
   
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleNotifications))
      
      refresh()
   }
   
   override func numberOfSections(in tableView: UITableView) -> Int {
      return 1
   }
   
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return pendingNotifications.count
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      
      let target = pendingNotifications[indexPath.row]
      cell.textLabel?.text = target.content.title
      cell.detailTextLabel?.text = target.identifier
      
      return cell
   }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let target = pendingNotifications[indexPath.row]
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [target.identifier])
            pendingNotifications.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
