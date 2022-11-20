import UIKit

class FirstResponderViewController: UIViewController {
    
    @IBOutlet weak var inputField: UITextField!
    
    
    @IBAction func startEditing(_ sender: Any) {
        inputField.becomeFirstResponder()
    }
    
    @IBAction func endEditing(_ sender: Any) {
        if inputField.isFirstResponder {
            inputField.resignFirstResponder()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        inputField.becomeFirstResponder()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        if inputField.isFirstResponder {
//            inputField.resignFirstResponder()
//        }
        view.endEditing(true) //에디팅 종료 (여러개의 input이 있을 경우)
    }
}
