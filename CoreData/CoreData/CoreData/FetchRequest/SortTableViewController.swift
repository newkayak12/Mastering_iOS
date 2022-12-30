import UIKit
import CoreData

class SortTableViewController: UITableViewController {
   
   var list = [NSManagedObject]()
   
   @IBAction func showMenu(_ sender: Any) {
      showSortMenu()
   }
   
   func sortByNameASC() {
      let sortByNameASC = NSSortDescriptor(key: "name", ascending: true)
       fetch(sortDescriptors: [sortByNameASC])
   }
   
   func sortByNameDESC() {
       let sortByNameDESC = NSSortDescriptor(key: #keyPath(EmployeeEntity.name), ascending: false)
       fetch(sortDescriptors: [sortByNameDESC])
   }
   
   func sortByAgeThenBySalary() {
       let sortByAgeASC = NSSortDescriptor(key: #keyPath(EmployeeEntity.age), ascending: true)
       let sortBySalaryDESC = NSSortDescriptor(key: #keyPath(EmployeeEntity.salary), ascending: false)
       fetch(sortDescriptors: [sortByAgeASC, sortBySalaryDESC]);
   }
   
   func fetch(sortDescriptors: [NSSortDescriptor]? = nil) {
      let request = NSFetchRequest<NSManagedObject>(entityName: "Employee")

      request.sortDescriptors = sortDescriptors

      do {
         list = try DataManager.shared.mainContext.fetch(request)
         tableView.reloadData()
      } catch {
         fatalError(error.localizedDescription)
      }
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      fetch()
   }
}


extension SortTableViewController {
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return list.count
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      
      let target = list[indexPath.row]
      if let name = target.value(forKey: "name") as? String, let salary = target.value(forKey: "salary") as? Int {
         cell.textLabel?.text = "[$\(salary)] \(name)"
      }
      
      if let age = target.value(forKey: "age") as? Int {
         cell.detailTextLabel?.text = "\(age)"
      }
      
      return cell
   }
}


extension SortTableViewController {
   func showSortMenu() {
      let alert = UIAlertController(title: "Sort", message: "Select sort type", preferredStyle: .alert)
      
      let nameASC = UIAlertAction(title: "name ASC", style: .default) { (action) in
         self.sortByNameASC()
      }
      alert.addAction(nameASC)
      
      let nameDESC = UIAlertAction(title: "name DESC", style: .default) { (action) in
         self.sortByNameDESC()
      }
      alert.addAction(nameDESC)
      
      let ageAndSalary = UIAlertAction(title: "age ASC salary DESC", style: .default) { (action) in
         self.sortByAgeThenBySalary()
      }
      alert.addAction(ageAndSalary)
      
      let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      alert.addAction(cancel)
      
      present(alert, animated: true, completion: nil)
   }
}
