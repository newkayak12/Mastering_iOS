
import UIKit

class CorrectionViewController: UIViewController {
    @IBOutlet weak var inputField: UITextField!
    
    @IBAction func correctionChanged(_ sender: UISegmentedControl) {
        inputField.resignFirstResponder()
        let type = UITextAutocapitalizationType(rawValue: sender.selectedSegmentIndex) ?? .none
        inputField.autocapitalizationType = type
        inputField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}
