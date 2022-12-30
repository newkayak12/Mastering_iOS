import UIKit
import CoreData

class RDepartmentComposerTableViewController: UITableViewController {
   
   var department: DepartmentEntity?
   var list = [EmployeeEntity]()
   
   @IBAction func cancel(_ sender: Any) {
      dismiss(animated: true, completion: nil)
   }
   
   @IBAction func save(_ sender: Any) {
      guard let targetDept = department else {
         fatalError()
      }
      
       guard let selectedIndexPaths = tableView.indexPathsForSelectedRows else { fatalError() }
       let selectedEmployees = selectedIndexPaths.map { list[$0.row] }
       for employee in selectedEmployees {
           targetDept.addToEmployees(employee)
           employee.department = targetDept
       }
       DataManager.shared.saveMainContext()
      dismiss(animated: true, completion: nil)
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
       list = DataManager.shared.fetchNotAssignedEmployee()
       tableView.reloadData()
   }
}


extension RDepartmentComposerTableViewController {
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return list.count
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      
      cell.textLabel?.text = list[indexPath.row].value(forKey: "name") as? String
      cell.detailTextLabel?.text = list[indexPath.row].value(forKey: "address") as? String
      
      return cell
   }
   
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let cell = tableView.cellForRow(at: indexPath)
      cell?.accessoryType = .checkmark
   }
   
   override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
      let cell = tableView.cellForRow(at: indexPath)
      cell?.accessoryType = .none
   }
}
