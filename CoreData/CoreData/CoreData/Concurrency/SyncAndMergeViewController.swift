
import UIKit
import CoreData


class SyncAndMergeViewController: UIViewController {
   
   lazy var formatter: NumberFormatter = {
      let f = NumberFormatter()
      f.locale = Locale(identifier: "en_US")
      f.numberStyle = .currency
      return f
   }()
   
   @IBOutlet weak var nameLabel: UILabel!
   
   @IBOutlet weak var mainContextSalaryLabel: UILabel!
   
   @IBOutlet weak var backgroundContextSalaryLabel: UILabel!
   
   var employeeInMainContext: EmployeeEntity?
   var employeeInBackgroundContext: EmployeeEntity?
   
   let mainContext = DataManager.shared.mainContext
   let backgroundContext = DataManager.shared.backgroundContext
   
   @IBAction func fetchIntoMainContext(_ sender: Any) {
       mainContext.perform {
           self.employeeInMainContext = DataManager.shared.fetchEmployee(in: self.mainContext)
           
           print(self.employeeInMainContext)
           self.nameLabel.text = self.employeeInMainContext?.name
           self.mainContextSalaryLabel.text = self.formatter.string(from: self.employeeInMainContext?.salary ?? 0)
       }
   }
   
   @IBAction func fetchIntoBackgroundContext(_ sender: Any) {
       backgroundContext.perform {
           self.employeeInBackgroundContext = DataManager.shared.fetchEmployee(in: self.backgroundContext)
           print(self.employeeInBackgroundContext)
           let salary = self.employeeInBackgroundContext?.salary
           DispatchQueue.main.async {
               self.backgroundContextSalaryLabel.text = self.formatter.string(from: salary ?? 0)
           }
           
       }
   }
   
   @IBAction func updateInMainContext(_ sender: Any) {
       mainContext.perform {
           let newSalary = NSDecimalNumber(integerLiteral: Int.random(in: 30...90) * 1000)
           self.employeeInMainContext?.salary = newSalary
           self.mainContextSalaryLabel.text = self.formatter.string(from: newSalary)
       }
   }

   @IBAction func updateInBackgroundContext(_ sender: Any) {
       backgroundContext.perform {
           let newSalary = NSDecimalNumber(integerLiteral: Int.random(in: 30...90) * 1000)
           self.employeeInBackgroundContext?.salary = newSalary
           DispatchQueue.main.async {
               self.backgroundContextSalaryLabel.text = self.formatter.string(from: newSalary)
           }
       }
   }
   
   @IBAction func saveInMainContext(_ sender: Any) {
      mainContext.perform {
         do {
            try self.mainContext.save()
         } catch {
            print(error)
         }
      }
   }

   @IBAction func saveInBackgroundContext(_ sender: Any) {
      backgroundContext.perform {
         do {
            try self.backgroundContext.save()
         } catch {
            print(error)
         }
      }
   }
   
   @IBAction func refreshInMainContext(_ sender: Any) {
       mainContext.perform {
           self.mainContext.refresh(self.employeeInMainContext!, mergeChanges: true)
           self.mainContextSalaryLabel.text = self.formatter.string(from: self.employeeInMainContext?.salary ?? 0)
       }
   }
   
   @IBAction func refreshInBackgroundContext(_ sender: Any) {
       backgroundContext.perform {
           self.backgroundContext.refresh(self.employeeInBackgroundContext!, mergeChanges: true)
           let salary = self.employeeInBackgroundContext?.salary
           DispatchQueue.main.async {
               self.backgroundContextSalaryLabel.text = self.formatter.string(from: salary ?? 0)
           }
       }
   }
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
       mainContext.mergePolicy = NSOverwriteMergePolicy
       backgroundContext.mergePolicy = NSOverwriteMergePolicy
      
      NotificationCenter.default.addObserver(forName: NSNotification.Name.NSManagedObjectContextObjectsDidChange, object: nil, queue: OperationQueue.main) { (noti) in
         guard let userInfo = noti.userInfo else { return }
         guard let changedContext = noti.object as? NSManagedObjectContext else { return }

         print("===========================")

          
          if let inserts = userInfo[NSInsertedObjectsKey] as? Set<NSManagedObject>, inserts.count > 0 {
              
          }
          if let deletes = userInfo[NSDeletedObjectsKey] as? Set<NSManagedObject>, deletes.count > 0 {
              
          }
          if let updates = userInfo[NSUpdatedObjectsKey] as? Set<NSManagedObject>, updates.count > 0 {
              guard changedContext != self.backgroundContext else { return }
              
              for update in updates {
                  self.backgroundContext.perform {
                      for (key, value) in update.changedValues(){
                          self.employeeInBackgroundContext?.setValue(value, forKey: key)
                      }
                      
                      let salary = self.employeeInBackgroundContext?.salary
                      DispatchQueue.main.async {
                          self.backgroundContextSalaryLabel.text = self.formatter.string(from: salary ?? 0)
                      }
                  }
              }
          }
      }
   }
}
