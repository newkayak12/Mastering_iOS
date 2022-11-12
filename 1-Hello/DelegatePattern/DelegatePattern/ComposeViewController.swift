import UIKit

class ComposeViewController: UIViewController {
    
    var delegate: ComposeDelegate? 
    
    @IBOutlet weak var inputField: UITextField!
    
    @IBAction func performCancel(_ sender: Any) {
        delegate?.composerDidCancel(self)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func performDone(_ sender: Any) {
        delegate?.composer(self, didInput: inputField.text)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            isModalInPresentation = true
        } 
    }
}















