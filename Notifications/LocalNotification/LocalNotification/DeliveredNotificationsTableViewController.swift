import UIKit
import UserNotifications

class DeliveredNotificationsTableViewController: UITableViewController {
   var deliveredNotifications = [UNNotification]()
   
   func refresh() {
      deliveredNotifications.removeAll()
      
       
       UNUserNotificationCenter.current().getDeliveredNotifications { [weak self] (notifications) in
           self?.deliveredNotifications = notifications
           
           DispatchQueue.main.async {
               self?.tableView.reloadData()
           }
           
       }
   }   
  
   override func viewDidLoad() {
      super.viewDidLoad()
      
      refresh()
   }
   
   override func numberOfSections(in tableView: UITableView) -> Int {
      return 1
   }
   
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return deliveredNotifications.count
   }
   
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      
      let target = deliveredNotifications[indexPath.row]
      cell.textLabel?.text = target.request.content.title
      cell.detailTextLabel?.text = target.request.identifier
      
      return cell
   }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let target = deliveredNotifications[indexPath.row]
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [target.request.identifier])
        deliveredNotifications.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
