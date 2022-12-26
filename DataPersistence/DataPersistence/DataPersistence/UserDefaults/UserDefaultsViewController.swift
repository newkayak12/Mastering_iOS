/**
 Number Types [Bool, String, Data, Array, Dictionary, Date, URL]
 NSCoding
 */

import UIKit
 

class UserDefaultsViewController: UIViewController {
   
   @IBOutlet weak var keyLabel: UILabel!
   
   @IBOutlet weak var valueLabel: UILabel!
   
   @IBOutlet weak var lastUpdatedLabel: UILabel!
   
    let key = "sampleKey"
   func updateDateLabel() {
      let formatter = DateFormatter()
      formatter.dateStyle = .none
      formatter.timeStyle = .medium
      
      lastUpdatedLabel.text = formatter.string(from: Date())
   }
   
   @IBAction func saveData(_ sender: Any) {
//       UserDefaults.standard.set("Hello", forKey: key)
       UserDefaults.standard.set(12.34, forKey: key)
   }
   
   @IBAction func loadData(_ sender: Any) {
//       valueLabel.text = UserDefaults.standard.string(forKey: key) ?? "not set"
       valueLabel.text = "\(UserDefaults.standard.integer(forKey: thresholdKey))"
       keyLabel.text = thresholdKey
   }
    
    var token: NSObjectProtocol?
    
    deinit {
        if let token = token {
            NotificationCenter.default.removeObserver(token)
        }
    }
   
   override func viewDidLoad() {
      super.viewDidLoad()
//       print(UserDefaults.standard.dictionaryRepresentation())
//       print(UserDefaults.standard.dictionaryWithValues(forKeys: [key]))
       
//       UserDefaults.standard.set(nil, forKey: key)//이렇게 지우거나
//       UserDefaults.standard.removeObject(forKey: key) //이렇게 지우거나
       token = NotificationCenter.default.addObserver(forName: UserDefaults.didChangeNotification, object: nil, queue: OperationQueue.main, using: { [weak self] (noti) in
           self?.updateDateLabel()
       })
   }
}
