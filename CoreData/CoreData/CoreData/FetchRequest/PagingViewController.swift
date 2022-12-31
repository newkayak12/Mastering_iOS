import UIKit
import CoreData

class PagingViewController: UIViewController {
   
   let context = DataManager.shared.mainContext
   var offset = 0
   
   var list = [NSManagedObject]()
   
   @IBOutlet weak var listTableView: UITableView!
   
   @IBOutlet weak var pageLabel: UILabel!
   
   @IBAction func prev(_ sender: Any) {
      offset = max(offset - 1, 0)
      fetch()
   }
   
   @IBAction func next(_ sender: Any) {
      offset = offset + 1
      fetch()
   }
   
   func fetch() {
      let request = NSFetchRequest<NSManagedObject>(entityName: "Employee")

       //fetchlimit, offset
       
       request.fetchLimit = 10
       request.fetchOffset = offset
      
      let sortByName = NSSortDescriptor(key: "name", ascending: true)
      request.sortDescriptors = [sortByName]
      
      do {
         list = try context.fetch(request)
         listTableView.reloadData()
         pageLabel.text = "\(offset + 1)"
      } catch {
         fatalError(error.localizedDescription)
      }
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      fetch()
   }
}

extension PagingViewController: UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return list.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      
      cell.textLabel?.text = list[indexPath.row].value(forKey: "name") as? String
      
      return cell
   }
}
