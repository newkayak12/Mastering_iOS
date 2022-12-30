import UIKit
import CoreData

class FetchAllViewController: UITableViewController {
   
   var list = [NSManagedObject]()
   
   @IBAction func fetch(_ sender: Any?) {
      let context = DataManager.shared.mainContext
//MARK: - 1
//       let request = NSFetchRequest<NSManagedObject>()
//       let entity = NSEntityDescription.entity(forEntityName: "Employee", in: context)
//       request.entity = entity
       
//MARK: - 2
//       let request = NSFetchRequest<NSManagedObject>(entityName: "Employee")

//MARK: - 3
       let request: NSFetchRequest<EmployeeEntity> = EmployeeEntity.fetchRequest()
//       request.execute() //execute로 요청을 직접 처리할 수도 있다.
       
       do {
           
           list = try context.fetch(request) //배열로 반환
           tableView.reloadData()
       } catch {
           fatalError(error.localizedDescription)
       }
      
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      fetch(nil)
   }
}


extension FetchAllViewController {
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return list.count
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      
      cell.textLabel?.text = list[indexPath.row].value(forKey: "name") as? String
      
      return cell
   }
}
