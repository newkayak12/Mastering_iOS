import UIKit
import CoreData

class ValidationViewController: UIViewController {

   let departmentList = DataManager.shared.fetchDepartment()
   var selectedDepartment: DepartmentEntity?

   @IBOutlet weak var nameField: UITextField!

   @IBOutlet weak var ageSlider: UISlider!
   @IBOutlet weak var ageValueLabel: UILabel!

   @IBOutlet weak var departmentButton: UIButton!


   @IBAction func save(_ sender: Any) {
      
   }


   @IBAction func validate(_ sender: Any) {
      guard let name = nameField.text else { return }
      let age = Int16(ageSlider.value)
      let context = DataManager.shared.mainContext

       let newEmployee = EmployeeEntity(context: context)
       newEmployee.name = name
       newEmployee.age = age
       newEmployee.department = selectedDepartment
       
       do {
           try newEmployee.validateForInsert()
       } catch let error as NSError {
//           print("Domain ========")
//           print(error.domain)
//           print("Code ========")
//           print(error.code)
//           print("Description ========")
//           print(error.localizedDescription)
//           print("User Info ========")
//           print(error.userInfo)
           //MARK: - WTF!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
           switch error.code {
           case NSValidationStringTooShortError, NSValidationStringTooLongError :
               if let attr = error.userInfo[NSValidationKeyErrorKey] as? String, attr == "name" {
                   showAlert(message: "Please enter a name between 2 and 30 characters.")
               } else {
                   showAlert(message: "Please enter a valid value.")
               }
           case NSValidationNumberTooSmallError, NSValidationNumberTooLargeError:
               print("TOOLARGE OR SMALL")
               if let msg = error.userInfo[NSLocalizedDescriptionKey] as? String { showAlert(message:  msg)}
               else { showAlert(message: "Please enter a valid value.")}
               
//           case NSValidationInvalidAgeAndDepartment:
//               if let attr = error.userInfo[NSValidationKeyErrorKey] as? String, attr == "name" {
//                   showAlert(message: "Please enter a name between 2 and 30 characters.")
//               }
           default:
               break;
           }
       }
       
       context.rollback()
      
   }


   @IBAction func sliderChanged(_ sender: UISlider) {
      ageValueLabel.text = "\(Int(sender.value))"
   }

   @IBAction func selecteDepartment(_ sender: Any) {
      showDepartmentList()
   }

   override func viewDidLoad() {
      super.viewDidLoad()

      DataManager.shared.mainContext.undoManager = UndoManager()
   }

   deinit {
      DataManager.shared.mainContext.undoManager = nil
   }
}


extension ValidationViewController {
   func showDepartmentList() {
      let alert = UIAlertController(title: nil, message: "Select Department", preferredStyle: .alert)

      for dept in departmentList {
         let departmentAction = UIAlertAction(title: dept.name, style: .default) { (action) in
            self.selectedDepartment = dept
            self.departmentButton.setTitle(dept.name, for: .normal)
         }
         alert.addAction(departmentAction)
      }

      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
         self.selectedDepartment = nil
         self.departmentButton.setTitle("None", for: .normal)
      }
      alert.addAction(cancelAction)

      present(alert, animated: true, completion: nil)
   }
   
   func showAlert(message: String) {
      let alert = UIAlertController(title: "Validation", message: message, preferredStyle: .alert)
      
      let okAction = UIAlertAction(title: "Ok", style: .cancel) { (action) in
      }
      alert.addAction(okAction)
      
      present(alert, animated: true, completion: nil)
   }
}

