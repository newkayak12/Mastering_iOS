import UIKit
import CoreData

class FetchedResultsControllerTableViewController: UITableViewController {
   
   lazy var fetchRequest: NSFetchRequest<EmployeeEntity> = {
      let request = NSFetchRequest<EmployeeEntity>(entityName: "Employee")
      request.predicate = NSPredicate(format: "department != NIL")
      let sortByName = NSSortDescriptor(key: "name", ascending: true)
      let sortByDeptName = NSSortDescriptor(key: "department.name", ascending: false)
      request.sortDescriptors = [sortByDeptName, sortByName]
      request.fetchBatchSize = 30
      return request
   }()
    
    lazy var resultcontroller: NSFetchedResultsController<EmployeeEntity> = {
        [weak self] in
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: DataManager.shared.mainContext, sectionNameKeyPath: #keyPath(EmployeeEntity.department.name), cacheName: "CacheByDeptName")
        
        //groupBy, Caching
        
        
        controller.delegate = self
        return controller
    }()
    
    
   @IBAction func showMenu(_ sender: Any) {
      showMenu()
   }
   

   
   
   func changeSortOrder() {
       
       NSFetchedResultsController<EmployeeEntity>.deleteCache(withName: resultcontroller.cacheName)
      
       let sortByDeptName = NSSortDescriptor(key: "department.name", ascending: false)
       let sortBySalary = NSSortDescriptor(key: "salary", ascending: true)
       resultcontroller.fetchRequest.sortDescriptors = [sortByDeptName, sortBySalary]
       //단순히 sortDescriptor 바꾸는 걸로 X performFetch
       
       do {
           try resultcontroller.performFetch()
           tableView.reloadData()
       } catch {
           print(error.localizedDescription)
       }
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
       do {
           try resultcontroller.performFetch()
       } catch {
           print(error.localizedDescription)
       }
       
//       NSFetchedResultsController<EmployeeEntity>.deleteCache(withName: "CacheByDeptName")// 해당 캐시 삭제
//       NSFetchedResultsController<EmployeeEntity>.deleteCache(withName: nil)// 전체 캐시 삭제
       
      
   }
   
    deinit {
        resultcontroller.delegate = nil
    }
}

extension FetchedResultsControllerTableViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let insertIndexPath = newIndexPath {
                tableView?.insertRows(at:[insertIndexPath], with: .automatic)
            }
        case .delete:
            if let deleteIndexPath = indexPath {
                tableView.deleteRows(at: [deleteIndexPath], with: .fade)
            }
        case .update:
            if let updateIndexPath = indexPath  {
                tableView.reloadRows(at: [updateIndexPath], with: .fade)
            }
        case .move:
            if let originalIndexPath = indexPath, let targetIndexPath = newIndexPath {
                tableView.moveRow(at: originalIndexPath, to: targetIndexPath)
            }
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .automatic)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .automatic)
        default:
            break;
        }
    }
}


extension FetchedResultsControllerTableViewController {
   override func numberOfSections(in tableView: UITableView) -> Int {
       return resultcontroller.sections?.count ?? 0
   }
   
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       guard let sections = resultcontroller.sections else { return 0 }
       let sectionInfo = sections[section]
       return sectionInfo.numberOfObjects
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      
       let target = resultcontroller.object(at: indexPath)
       cell.textLabel?.text = target.name
       cell.detailTextLabel?.text = target.department?.name
      
      return cell
   }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return resultcontroller.sections?[section].name
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return resultcontroller.sectionIndexTitles
    }
}


extension FetchedResultsControllerTableViewController {
   func showMenu() {
      let alert = UIAlertController(title: "Fetched Results Controller", message: nil, preferredStyle: .alert)
      
      let addAction = UIAlertAction(title: "Add Employee", style: .default) { (action) in
         let context = DataManager.shared.mainContext
         
         let newEmployee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context)
         newEmployee.setValue("Aaden Smith", forKey: "name")
         newEmployee.setValue(50, forKey: "age")
         
         DataManager.shared.saveMainContext()
      }
      alert.addAction(addAction)
      
      let deleteAction = UIAlertAction(title: "Delete Employee", style: .destructive) { (action) in
         let context = DataManager.shared.mainContext
         
         let request = NSFetchRequest<NSManagedObject>(entityName: "Employee")
         request.fetchLimit = 1
         
         let filterByName = NSPredicate(format: "name == %@", "Aaden Smith")
         request.predicate = filterByName
         
         let sortByName = NSSortDescriptor(key: "name", ascending: true)
         request.sortDescriptors = [sortByName]
         
         do {
            if let first = try context.fetch(request).first {
               context.delete(first)
               DataManager.shared.saveMainContext()
            }
         } catch {
            print(error.localizedDescription)
         }
      }
      alert.addAction(deleteAction)
      
      let changeSortOrderAction = UIAlertAction(title: "Change Sort Order", style: .default) { (action) in
         self.changeSortOrder()
      }
      alert.addAction(changeSortOrderAction)
      
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      alert.addAction(cancelAction)
      
      present(alert, animated: true, completion: nil)
   }
}
