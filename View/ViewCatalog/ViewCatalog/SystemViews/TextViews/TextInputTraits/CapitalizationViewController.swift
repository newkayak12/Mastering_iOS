import UIKit

class CapitalizationViewController: UIViewController {
    
    @IBOutlet weak var inputField: UITextField!
    
    @IBAction func capitalizationChanged(_ sender: UISegmentedControl) {
        inputField.resignFirstResponder()
        let type = UITextAutocapitalizationType(rawValue: sender.selectedSegmentIndex) ?? .none
        print(type)
        inputField.autocapitalizationType = type
        inputField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}
