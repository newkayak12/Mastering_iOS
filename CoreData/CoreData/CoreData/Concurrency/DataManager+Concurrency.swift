
import Foundation
import CoreData


extension DataManager {
   func batchInsert(in context: NSManagedObjectContext) {
      context.perform {
         let start = Date().timeIntervalSinceReferenceDate
         
         let departmentList = DepartmentJSON.parsed()
         let employeeList = EmployeeJSON.parsed()
         
         for dept in departmentList {
            guard let newDeptEntity = DataManager.shared.insertDepartment(from: dept, in: context) else {
               fatalError()
            }
            
            let employeesInDept = employeeList.filter { $0.department == dept.id }
            for emp in employeesInDept {
               guard let newEmployeeEntity = DataManager.shared.insertEmployee(from: emp, in: context) else {
                  fatalError()
               }
               
               newDeptEntity.addToEmployees(newEmployeeEntity)
               newEmployeeEntity.department = newDeptEntity
            }
            
            do {
               try context.save()
                
                if let parent = context.parent, parent.hasChanges {
                    try parent.save()
                }
            } catch {
               dump(error)
            }
         }
         
         let otherEmployees = employeeList.filter { $0.department == 0 }
         for emp in otherEmployees {
            _ = DataManager.shared.insertEmployee(from: emp, in: context)
         }
         
         do {
            try context.save()
            
         } catch {
            dump(error)
         }
         
         let end = Date().timeIntervalSinceReferenceDate
         print(end - start)
      }
   }
   
   func fetchEmployee(in context: NSManagedObjectContext) -> EmployeeEntity? {
      var data: EmployeeEntity?
      
      context.performAndWait {
         let request: NSFetchRequest<EmployeeEntity> = EmployeeEntity.fetchRequest()
         request.predicate = NSPredicate(format: "%K == %@", #keyPath(EmployeeEntity.name), "Aaden George")
         request.fetchLimit = 1
         
         do {
            if let first = try context.fetch(request).first {
               data = first
            }
         } catch {
            print(error)
         }
      }
      
      return data
   }
}
