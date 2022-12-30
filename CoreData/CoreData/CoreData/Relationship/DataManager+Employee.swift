import Foundation
import CoreData

extension DataManager {
   func fetchNotAssignedEmployee() -> [EmployeeEntity] {
      var list = [EmployeeEntity]()
      
      mainContext.performAndWait {
         let request: NSFetchRequest<EmployeeEntity> = EmployeeEntity.fetchRequest()
         
         let filterByDept = NSPredicate(format: "department == nil")
         request.predicate = filterByDept
         
         let sortByName = NSSortDescriptor(key: #keyPath(EmployeeEntity.name), ascending: true)
         request.sortDescriptors = [sortByName]
         
         do {
            list = try mainContext.fetch(request)
         } catch {
            fatalError(error.localizedDescription)
         }
      }
      
      return list
   }
}
