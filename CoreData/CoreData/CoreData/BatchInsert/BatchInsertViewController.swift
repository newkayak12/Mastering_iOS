
import UIKit
import CoreData

class BatchInsertViewController: UIViewController {
   
   @IBOutlet weak var countLabel: UILabel!
   
   var importCount = 0
   
   @IBAction func batchInsert(_ sender: UIButton) {
      sender.isEnabled = false
      importCount = 0
      
      DispatchQueue.global().async {
         let start = Date().timeIntervalSinceReferenceDate
         
          let departmentList = DepartmentJSON.parsed()
          let employeeList = EmployeeJSON.parsed()
          
          let context = DataManager.shared.mainContext
          context.performAndWait {
              for dept in departmentList {
                  guard let newDeptEntity = DataManager.shared.insertDepartment(from: dept, in: context) else {
                      fatalError()
                  }
                  
                  let employeesInDept = employeeList.filter { $0.department == dept.id  }
                  
                  for emp in employeesInDept {
                      guard let newEmployeeEntity = DataManager.shared.insertEmployee(from: emp, in: context) else { fatalError()
                          
                      }
                      newDeptEntity.addToEmployees(newEmployeeEntity)
                      newEmployeeEntity.department = newDeptEntity
                      
                      self.importCount += 1
                      DispatchQueue.main.async {
                          self.countLabel.text = "\(self.importCount)"
                      }
                  }
                  
                  do {
                      try context.save()
                  } catch {
                      print(error.localizedDescription)
                  }
              }
              
              let otherEmployees = employeeList.filter {$0.department == 0}
              for emp in otherEmployees {
                  _ = DataManager.shared.insertEmployee(from: emp, in: context)
                  self.importCount += 1
                  
                  DispatchQueue.main.async {
                      self.countLabel.text = "\(self.importCount)"
                  }
              }
              do {
                  try context.save()
              } catch {
                  print(error.localizedDescription)
              }
          }
         
         DispatchQueue.main.async {
            sender.isEnabled = true
            self.countLabel.text = "Done"
            
            let end = Date().timeIntervalSinceReferenceDate
            print(end - start)
         }
      }
   }
}
