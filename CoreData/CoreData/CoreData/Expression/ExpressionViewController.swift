import UIKit
import CoreData

class ExpressionViewController: UIViewController {
   lazy var formatter: NumberFormatter = {
      let f = NumberFormatter()
      f.locale = Locale(identifier: "en_US")
      f.numberStyle = .currency
      return f
   }()
   
   var list = [Any]()
   
   @IBOutlet weak var listTableView: UITableView!
   
   func fetch() {
      let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Department")
      
      let sortByName = NSSortDescriptor(key: "name", ascending: true)
      request.sortDescriptors = [sortByName]
      
       request.resultType = .dictionaryResultType
       
       let employeeCountExprDescription = NSExpressionDescription()
       employeeCountExprDescription.name = "count" //Dictionary's Key
       
       let countArg = NSExpression(forKeyPath: "employees")
       let countExpr  = NSExpression(forFunction: "count:", arguments: [countArg])//강의페이지 목록에서 다른 함수도 확인할 수 있음
       
       employeeCountExprDescription.expression = countExpr
       employeeCountExprDescription.expressionResultType = .integer64AttributeType
       
       
       let averageSalaryExprDescription = NSExpressionDescription()
       averageSalaryExprDescription.name = "avg"
       
       let salaryArg = NSExpression(forKeyPath: "employees.salary")
       averageSalaryExprDescription.expression = NSExpression(forFunction: "average:", arguments: [salaryArg])
       averageSalaryExprDescription.expressionResultType = .decimalAttributeType
       
       
       request.propertiesToFetch = ["name", employeeCountExprDescription, averageSalaryExprDescription]
      
      
      do {
         list = try DataManager.shared.mainContext.fetch(request)
         listTableView.reloadData()
      } catch {
         fatalError(error.localizedDescription)
      }
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      fetch()
   }
}


extension ExpressionViewController: UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return list.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      
      
      if let target = list[indexPath.row] as? NSManagedObject {
         let count = target.value(forKeyPath: "employees.@count.intValue") as? Int
         let avg = target.value(forKeyPath: "employees.@avg.salary.doubleValue") as? Double
         
         if let name = target.value(forKey: "name") as? String, let count = count {
            cell.textLabel?.text = "\(name)\n\(count) employees"
         }
         
         let avgStr = formatter.string(for: avg ?? 0) ?? "0"
         cell.detailTextLabel?.text = avgStr
      } else if let target = list[indexPath.row] as? [String: Any] {
         let count = target["count"] as? Int
         let avg = target["avg"] as? Double
         
         if let name = target["name"] as? String, let count = count {
            cell.textLabel?.text = "\(name)\n\(count) employees"
         }
         
         let avgStr = formatter.string(for: avg ?? 0) ?? "0"
         cell.detailTextLabel?.text = avgStr
      }
      
      
      return cell
   }
}
