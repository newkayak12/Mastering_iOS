import UIKit
import CoreData

class ResultTypesViewController: UIViewController {
   
   let context = DataManager.shared.mainContext
   
   @IBAction func fetchManagedObject(_ sender: Any) {
      let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
       //rawType
       request.resultType = .managedObjectResultType
      do {
         let list = try context.fetch(request)
         if let first = list.first {
            print(type(of: first))
            print(first)                        
         }
      } catch {
         fatalError(error.localizedDescription)
      }
   }
   
   @IBAction func fetchCount(_ sender: Any) {
      let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
       
       request.resultType = .countResultType
      do {
         let list = try context.fetch(request)
         if let first = list.first {
            print(type(of: first))
            print(first)
         }
          
          let cnt = try context.count(for: request)//이게 더 빠름 위의 .countResultType보다.
      } catch {
         fatalError(error.localizedDescription)
      }
   }
   
   @IBAction func fetchDictionary(_ sender: Any) {
      let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
      
       request.resultType = .dictionaryResultType
       request.propertiesToFetch = ["name", "address"]
      do {
         let list = try context.fetch(request)
         if let first = list.first {
            print(type(of: first))
            print(first)
         }
          
          
      } catch {
         fatalError(error.localizedDescription)
      }
   }
   
   @IBAction func fetchManagedObjectID(_ sender: Any) {
      let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
      
       request.resultType = .managedObjectIDResultType
       //PK
      do {
         let list = try context.fetch(request)
         if let first = list.first {
            print(type(of: first))
            print(first)
         }
      } catch {
         fatalError(error.localizedDescription)
      }
   }
}
