

import UIKit

class TextFieldViewController: UIViewController {
    
    @IBOutlet weak var inputField: UITextField!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputField.delegate = self
    }
}

extension TextFieldViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(#function)
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}






