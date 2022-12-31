import UIKit
import CoreData

class AsyncFetchingTableViewController: UITableViewController {
   
   var list = [NSManagedObject]()
   
   @IBAction func fetch(_ sender: Any?) {
      let request = NSFetchRequest<NSManagedObject>(entityName: "Employee")

      let sortByName = NSSortDescriptor(key: "name", ascending: true)
      request.sortDescriptors = [sortByName]
//    MARK: - asyncFetch
       let asyncResult = NSAsynchronousFetchRequest<NSManagedObject>(fetchRequest: request){
           (request) in
           guard let list = request.finalResult else { return }
           self.list = list
           self.tableView.reloadData()
           
       }
       

      do {
//         list = try DataManager.shared.mainContext.fetch(request)
          
// asyncMethod
          try DataManager.shared.mainContext.execute(asyncResult)
          //MARK: - ASYNC 관련 강의 페이지의 링크 참조
          
         tableView.reloadData()
      } catch {
         fatalError(error.localizedDescription)
      }
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      fetch(nil)
      tableView.reloadData()
   }
}


extension AsyncFetchingTableViewController {
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return list.count
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      
      cell.textLabel?.text = list[indexPath.row].value(forKey: "name") as? String
      
      return cell
   }
}
