import UIKit

class KeyboardAppearanceViewController: UIViewController {
    
    @IBOutlet weak var inputField: UITextField!
    
    @IBAction func appearanceChanged(_ sender: UISegmentedControl) {
        inputField.keyboardAppearance = UIKeyboardAppearance(rawValue: sender.selectedSegmentIndex) ?? .default
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        inputField.becomeFirstResponder()
    }
}
