
import UIKit

class ManagedObjectViewController: UIViewController {
   
    var list = [PersonEntity]()
    
   var token: NSObjectProtocol!
   @IBOutlet weak var listTableView: UITableView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
       list = DataManager.shared.fetchPerson()
       listTableView.reloadData()
       
      token = NotificationCenter.default.addObserver(forName: PersonComposeViewController.newPersonDidInsert, object: nil, queue: .main, using: { [weak self] (noti) in
          self?.list = DataManager.shared.fetchPerson()
          self?.listTableView.reloadData()
      })
      
   }
   
   deinit {
      NotificationCenter.default.removeObserver(token)
   }
}


extension ManagedObjectViewController: UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return list.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
       let person = list[indexPath.row]
       cell.textLabel?.text = person.name
       cell.detailTextLabel?.text = "\(person.age)"
      return cell
   }
   
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
      switch editingStyle {
      case .delete:
          let person = list.remove(at: indexPath.row)
          DataManager.shared.delete(entity: person)
          tableView.deleteRows(at: [indexPath], with: .automatic)
         break
      default:
         break
      }
   }
}


extension ManagedObjectViewController: UITableViewDelegate {
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
      
       let person = list[indexPath.row]
       if let nav = storyboard?.instantiateViewController(withIdentifier: "ComposeNav") as? UINavigationController, let composeVC = nav.viewControllers.first as? PersonComposeViewController {
           
           composeVC.target = person
           present(nav, animated: true, completion: nil)
       }
      
   }
}
