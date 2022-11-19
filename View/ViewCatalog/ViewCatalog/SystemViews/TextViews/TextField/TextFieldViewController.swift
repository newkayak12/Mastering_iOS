import UIKit

class TextFieldViewController: UIViewController {
    
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBAction func report(_ sender: Any) {
        guard let text = inputField.text, text.count > 0  else {
            return
        }
        valueLabel.text = text
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputField.placeholder = "input Value"
        valueLabel.text = inputField.text ?? ""
        
    }
}
