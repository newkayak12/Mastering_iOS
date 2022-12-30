
import UIKit
import CoreData

class REmployeeListViewController: UIViewController {
   var department: DepartmentEntity?
   var list = [EmployeeEntity]()
   
   @IBOutlet weak var listTableView: UITableView!
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let nav = segue.destination as? UINavigationController, let vc = nav.viewControllers.first as? RDepartmentComposerTableViewController {
         vc.department = department
      }
   }
   
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let employeeList = department?.employees?.allObjects as? [EmployeeEntity] else { return }
        list = employeeList.sorted{ $0.name! < $1.name!}
        listTableView.reloadData()
      
   }
}

extension REmployeeListViewController: UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return list.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
       let employee = list[indexPath.row]
       cell.textLabel?.text = employee.name
       cell.detailTextLabel?.text = employee.address
      
      return cell
   }
   
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
      switch editingStyle {
      case .delete:
          guard let dept = department else { fatalError() }
          let employee = list[indexPath.row]
          
          dept.removeFromEmployees(employee)
          employee.department = nil
          
          DataManager.shared.saveMainContext()
          
          list.remove(at: indexPath.row)
          tableView.deleteRows(at: [indexPath], with: .automatic)
         break
      default:
         break
      }
   }
}
