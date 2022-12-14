import UIKit

extension NSNotification.Name {
    static let NewValueDidInput = NSNotification.Name("NewValueDidInputNotification")
}

class ComposeViewController: UIViewController {
   
   @IBOutlet weak var inputField: UITextField!
   
   @IBAction func close(_ sender: Any) {
      dismiss(animated: true, completion: nil)
   }
   
   @IBAction func postValue(_ sender: Any) {
       guard let text = inputField.text else {return}
//       NotificationCenter.default.post(name: NSNotification.Name.NewValueDidInput, object: nil, userInfo: ["NewValue":text])
       DispatchQueue.global().async {
           NotificationCenter.default.post(name: NSNotification.Name.NewValueDidInput, object: nil, userInfo: ["NewValue":text])
       }
       //UICode를 Background에서 실행하면 에러

      dismiss(animated: true, completion: nil)
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      inputField.becomeFirstResponder()
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      
      inputField.resignFirstResponder()
   }
}
