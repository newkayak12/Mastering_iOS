import UIKit
import CoreData

class PredicateViewController: UIViewController {

   var list = [NSManagedObject]()
   
   @IBOutlet weak var listTableView: UITableView!
   
   func searchByName(_ keyword: String?) {
      guard let keyword = keyword else { return }
       let predicate = NSPredicate(format: "name CONTAINS[c] %@", keyword)
       fetch(predicate: predicate)
   }
   
   func searchByMinimumAge(_ keyword: String?) {
      guard let keyword = keyword, let age = Int(keyword) else { return }
       //파라미터로 전달된 이름을 인식
       let predicate = NSPredicate(format: "%K >= %d", #keyPath(EmployeeEntity.age), age)
      fetch(predicate: predicate)
   }
   
   func searchBySalaryRange(_ keyword: String?) {
      guard let keyword = keyword else { return }
      let comps = keyword.components(separatedBy: "-")
      guard comps.count == 2, let min = Int(comps[0]), let max = Int(comps[1]) else { return }
      // 30000-70000
      let predicate = NSPredicate(format: "%K BETWEEN {%d, %d}", #keyPath(EmployeeEntity.salary), min, max)
       fetch(predicate: predicate)
      
   }
   
   func searchByDeptName(_ keyword: String?) {
      guard let keyword = keyword else { return }
       let predicate = NSPredicate(format: "%K BEGINSWITH[c] %@", #keyPath(EmployeeEntity.department.name), keyword)
       fetch(predicate: predicate)
   }
   
   func fetch(predicate: NSPredicate? = nil) {
      let request = NSFetchRequest<NSManagedObject>(entityName: "Employee")
      
       request.predicate = predicate
      let sortByName = NSSortDescriptor(key: "name", ascending: true)
      request.sortDescriptors = [sortByName]
      
      do {
         list = try DataManager.shared.mainContext.fetch(request)
         listTableView.reloadData()
      } catch {
         fatalError(error.localizedDescription)
      }
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      fetch()
   }
}

extension PredicateViewController: UISearchBarDelegate {
   func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
      searchBar.text = nil
      searchBar.resignFirstResponder()
      fetch()
   }
   
   func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      switch searchBar.selectedScopeButtonIndex {
      case 0:
         searchByName(searchBar.text)
      case 1:
         searchByMinimumAge(searchBar.text)
      case 2:
         searchBySalaryRange(searchBar.text)
      case 3:
         searchByDeptName(searchBar.text)
      default:
         fatalError()
      }
   }
}

extension PredicateViewController: UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return list.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

      let target = list[indexPath.row]
      if let name = target.value(forKey: "name") as? String, let age = target.value(forKey: "age") as? Int, let departmentName = target.value(forKeyPath: "department.name") as? String {
         cell.textLabel?.text = "\(name) (\(age))\n\(departmentName)"
      }
      
      if let salary = target.value(forKey: "salary") as? Int {
         cell.detailTextLabel?.text = "$ \(salary)"
      }
      
      return cell
   }
}
