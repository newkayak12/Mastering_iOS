

import UIKit
import CoreData

class PersonComposeViewController: UIViewController {
   
   static let newPersonDidInsert = Notification.Name(rawValue: "newPersonDidInsert")
   
   var target: NSManagedObject?
   
   @IBOutlet weak var nameField: UITextField!
   
   @IBOutlet weak var ageField: UITextField!
   
   @IBAction func cancelCompose(_ sender: Any) {
      dismiss(animated: true, completion: nil)
   }
   
   @IBAction func save(_ sender: Any) {
      guard let name = nameField.text else { return }
      
      var age: Int?
      if let ageStr = ageField.text, let ageVal = Int(ageStr) {
         age = ageVal
      }
       
       if let target = target as? PersonEntity {
           DataManager.shared.updatePerson(entity: target, name: name, age: age){
               NotificationCenter.default.post(name: PersonComposeViewController.newPersonDidInsert, object: nil)
               self.dismiss(animated: true, completion: nil)
           }
           
       } else {
           DataManager.shared.createPerson(name: name, age: age) {
               NotificationCenter.default.post(name: PersonComposeViewController.newPersonDidInsert, object: nil)
               self.dismiss(animated: true, completion: nil)
           }
       }
       
      
      
      
     
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
       if let target = target as? PersonEntity {
           navigationItem.title = "Edit"
           nameField.text = target.name
           ageField.text = "\(target.age)"
       } else {
           navigationItem.title = "Add"
       }
      
   }
}
