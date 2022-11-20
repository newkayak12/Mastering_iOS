import UIKit

class SecureTextEntryViewController: UIViewController {
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordField.isSecureTextEntry = true
        
    }
}
