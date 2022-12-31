import UIKit
import CoreData

class TransformableTableViewController: UITableViewController {
   
   lazy var resultController: NSFetchedResultsController<NSManagedObject> = { [weak self] in
      let request = NSFetchRequest<NSManagedObject>(entityName: "Employee")
      
      let sortByName = NSSortDescriptor(key: "name", ascending: true)
      request.sortDescriptors = [sortByName]
      
      request.fetchBatchSize = 30
      
      let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: DataManager.shared.mainContext, sectionNameKeyPath: nil, cacheName: nil)
      controller.delegate = self
      return controller
      }()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      do {
         try resultController.performFetch()
      } catch {
         print(error.localizedDescription)
      }
   }
   
   deinit {
      resultController.delegate = nil
   }
}

extension TransformableTableViewController {
   override func numberOfSections(in tableView: UITableView) -> Int {
      return resultController.sections?.count ?? 0
   }
   
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      guard let sections = resultController.sections else { return 0 }
      let sectionInfo = sections[section]
      return sectionInfo.numberOfObjects
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      
      let target = resultController.object(at: indexPath)
      cell.textLabel?.text = target.value(forKey: "name") as? String
      
      if let contactData = target.value(forKey: "contact") as? Data {
         let contact = NSKeyedUnarchiver.unarchiveObject(with: contactData) as! Contact
         cell.detailTextLabel?.text = contact.tel
      } else if let _ = target.value(forKey: "contact") as? Contact {
         cell.detailTextLabel?.text = target.value(forKeyPath: "contact.tel") as? String
      } else {
         cell.detailTextLabel?.text = nil
      }
      
      return cell
   }
   
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
      
      let target = resultController.object(at: indexPath) as! EmployeeEntity
       if let contact = target.contact {
//           let contact = NSKeyedUnarchiver.unarchiveObject(with: contactData) as! Contact
           print(contact.tel, contact.fax, contact.email)
       } else {
//           let newContact = Contact.sample()
//           let data = NSKeyedArchiver.archivedData(withRootObject: newContact)
//           target.contact = data
           target.contact =  Contact.sample()
           DataManager.shared.saveMainContext()
       }
       
       
      
   }
}

extension TransformableTableViewController: NSFetchedResultsControllerDelegate {
   func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
      tableView.reloadData()
   }
}
