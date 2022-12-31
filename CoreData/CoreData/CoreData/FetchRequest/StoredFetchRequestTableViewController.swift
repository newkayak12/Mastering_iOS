import UIKit
import CoreData

class StoredFetchRequestTableViewController: UITableViewController {
   
   var list = [NSManagedObject]()
   
   func fetch() {
       guard let model = DataManager.shared.container?.managedObjectModel else { fatalError("Invalid Model")}
//       guard let request = model.fetchRequestTemplate(forName: "highSalary") as? NSFetchRequest<NSManagedObject> else { fatalError("NOT FOUND") }
       guard let request = model.fetchRequestFromTemplate(withName: "highSalary", substitutionVariables: ["deptName": "Dev"]) as? NSFetchRequest<NSManagedObject> else {fatalError("Not Found")}
       
       let sortBySalaryDesc = NSSortDescriptor(key: #keyPath(EmployeeEntity.salary), ascending: false)
       request.sortDescriptors = [sortBySalaryDesc] //model이 immutable ...
       do {
           list = try DataManager.shared.mainContext.fetch(request)
           tableView.reloadData()
       } catch {
           print(error)
       }
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      fetch()
   }
}


extension StoredFetchRequestTableViewController {
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return list.count
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      
      let target = list[indexPath.row]
      if let name = target.value(forKey: "name") as? String, let deptName = target.value(forKeyPath: "department.name") as? String {
         cell.textLabel?.text = "\(name)\n\(deptName)"
      }
      
      cell.detailTextLabel?.text = "$ \((target.value(forKey: "salary") as? Int) ?? 0)"
      
      return cell
   }
}
