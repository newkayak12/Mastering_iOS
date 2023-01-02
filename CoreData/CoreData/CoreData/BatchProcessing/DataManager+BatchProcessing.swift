
import Foundation
import CoreData

extension DataManager {
   func batchUpdate() {
      let update = NSBatchUpdateRequest(entityName: "Task")
       update.propertiesToUpdate = [#keyPath(TaskEntity.done): true]
       update.predicate = NSPredicate(format: "%K == No", #keyPath(TaskEntity.done))
       update.resultType = .updatedObjectsCountResultType
       
       do {
           if let result = try mainContext.execute(update) as? NSBatchUpdateResult, let cnt = result.result as? Int {
               print("UPdated: \(cnt)")
           }
           
       } catch {
           print(error.localizedDescription)
       }
   }
   
    func batchDelete() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        request.predicate = NSPredicate(format: "%K == YES", #keyPath(TaskEntity.done))
        let delete = NSBatchDeleteRequest(fetchRequest: request)
        delete.resultType = .resultTypeCount
        
        do {
            if let result = try mainContext.execute(delete) as? NSBatchDeleteResult, let cnt = result.result as? Int {
                print("Deleted: \(cnt)")
            }
            
        } catch {
            print(error.localizedDescription)
        }
   }
   
   func batchInsert() {
      mainContext.perform {
         for index in 0 ..< 10_000 {
            let newTask = TaskEntity(context: self.mainContext)
            newTask.task = "Task \(index + 1)"
            newTask.date = Date().addingTimeInterval(TimeInterval(3600 * 24 * Int.random(in: -365 ... 365)))
            
            if index % 1_000 == 0 {
               do {
                  try self.mainContext.save()
               } catch {
                  print(error.localizedDescription)
               }
            }
         }
         
         do {
            try self.mainContext.save()
            print("Inserted")
         } catch {
            print(error.localizedDescription)
         }
      }
   }
}
