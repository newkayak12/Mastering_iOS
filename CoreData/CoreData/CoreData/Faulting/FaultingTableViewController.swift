///
///faulting (proxy?)
///store -> fetch -> managedObject에 placeholder Object 저장(기본적인),
///실제 필요할 떄 access 필요한 만큼 캐시를 확인하고 없으면 가져온다. (firing faults)
///
///이렇게 메모리 사용량을 줄인다.
///
///그러나 fault를 여러 번 fire하면 오버헤드가 생긴다.
///
///Uniquing은 원래 아는..
///

import UIKit
import CoreData

class FaultingTableViewController: UITableViewController {
   
   var list = [NSManagedObject]()
   
   @IBAction func fire(_ sender: Any) {
       list.forEach {
           DataManager.shared.mainContext.refresh($0, mergeChanges: false)
       }
   }
   
   func fetchAllEmployee() -> [NSManagedObject] {
      let context = DataManager.shared.mainContext
      var list = [NSManagedObject]()
      
      context.performAndWait {
         let request = NSFetchRequest<NSManagedObject>(entityName: "Employee")

         let sortByName = NSSortDescriptor(key: "name", ascending: true)
         request.sortDescriptors = [sortByName]
         
         request.fetchLimit = 100
         
          request.returnsObjectsAsFaults = true
         do {
            list = try context.fetch(request)
         } catch {
            fatalError(error.localizedDescription)
         }
      }
      
      return list
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      list = fetchAllEmployee()
      tableView.reloadData()
   }
}

extension FaultingTableViewController {
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return list.count
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      
      let target = list[indexPath.row]
      cell.textLabel?.text = target.value(forKey: "name") as? String
      cell.detailTextLabel?.text = target.value(forKeyPath: "department.name") as? String
      
      return cell
   }
}
