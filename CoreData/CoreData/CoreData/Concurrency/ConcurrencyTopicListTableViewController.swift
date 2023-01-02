
import UIKit
import CoreData

class ConcurrencyTopicListTableViewController: UITableViewController {
   
   @IBAction func reset(_ sender: Any) {
      let context = DataManager.shared.mainContext
      let entityNames = ["Task", "Employee", "Department"]
      for name in entityNames {
         let request = NSFetchRequest<NSFetchRequestResult>(entityName: name)
         
         let delete = NSBatchDeleteRequest(fetchRequest: request)
         delete.resultType = .resultTypeCount
         
         do {
            if let result = try context.execute(delete) as? NSBatchDeleteResult, let cnt = result.result as? Int {
               print("Deleted: \(name), \(cnt)")
            }
         } catch {
            print(error)
         }
      }
   }
   
}
